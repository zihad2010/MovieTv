//
//  MovieListViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation
import RxSwift

public enum HomeError {
    case internetError(String)
    case serverMessage(String)
}

class MovieListViewModel:ViewModelProtocol {
    
    private let disposable = DisposeBag()
    public let movieList : PublishSubject<[EachItemViewModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
   
    func getResource() -> Resource<ResponseModel> {
        guard let url = URL.convertUrl(urlStr: URL.mvieListUrl) else {
            fatalError("URl was incorrect")
        }
        var resource = Resource<ResponseModel>(url: url)
        resource.httpMethod = .get
        return resource
    }
    
    func fetchDtaWith(resource: Resource<ResponseModel>) {
        
        guard Reachability.isConnectedToNetwork() else {
            self.error.onNext(.internetError(UIMessages.offline))
            return
        }
        
        self.loading.onNext(true)
        TMDbWebService.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] response in
                self?.loading.onNext(false)
                switch response{
                case .success(let data):
                    let movieList = data.results?.compactMap(EachItemViewModel.init)
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
            }).disposed(by: disposable)
    }
}

