//
//  MovieListViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation
import RxSwift
import RxCocoa

public enum ApiError {
    case internetError(String)
    case serverMessage(String)
}

class MovieListViewModel:ViewModelProtocol {
    
    private let disposable = DisposeBag()
    public let info: PublishSubject<Info> = PublishSubject()
    public let movieList : PublishSubject<[EachItemViewModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ApiError> = PublishSubject()
    private let _movieInfo = BehaviorRelay<String>(value: "")
   
    func getResource<T>(value:T.Type) -> Any {
        guard let url = URL.convertUrl(urlStr: URL.mvieListUrl) else {
            fatalError("URl was incorrect")
        }
        var resource = Resource<ResponseModel>(url: url)
        resource.httpMethod = .get
        return resource
    }
    
    func fetchDtaWith<T>(resource: Resource<T>) {
        
        guard Reachability.isConnectedToNetwork() else {
            self.error.onNext(.internetError(UIMessages.offline))
            return
        }
        
        self.loading.onNext(true)
        TMDbWebService
            .load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] response in
                self?.loading.onNext(false)
                switch response{
                case .success(let data ):
                    print(data)
                    let data = data as! ResponseModel
                    let movieList = data.results?.map({ (item) -> EachItemViewModel in
                        return EachItemViewModel(item)
                    })
                    if let movieList = movieList{
                        self?.movieList.onNext(movieList)
                    }
                case .failure(let failure):
                    switch failure {
                    case .unknownError:
                        self?.error.onNext(.serverMessage(UIMessages.error))
                    case .authorizationError(_):
                        self?.error.onNext(.serverMessage(UIMessages.error))
                    default:
                        self?.error.onNext(.serverMessage(UIMessages.error))
                    }
                }
            }, onError: {[weak self] (error) in
                self?.loading.onNext(false)
                self?.error.onNext(.serverMessage(error.localizedDescription))
            })
            .disposed(by: disposable)
    }
}

