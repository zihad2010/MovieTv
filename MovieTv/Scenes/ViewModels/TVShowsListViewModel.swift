//
//  TVShowsViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import Foundation
import RxSwift

class TVShowsListViewModel: ViewModelProtocol {
    
    private let disposable = DisposeBag()
    public let info: PublishSubject<Info> = PublishSubject()
    public let tvShowsList : PublishSubject<[EachItemViewModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ApiError> = PublishSubject()
    
    func getResource<T>(value:T.Type) -> Any {
        guard let url = URL.convertUrl(urlStr: URL.tvShowsListUrl) else {
            fatalError("URl was incorrect")
        }
        var resource = Resource<ResponseModel>(url: url)
        resource.httpMethod = .get
        return resource
    }
    
    func fetchDtaWith<T>(resource: Resource<T>)  {
        
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
                case .success(let data):
                    let data = data as! ResponseModel
                    let tvShowsList = data.results?.compactMap(EachItemViewModel.init)
                    if let tvShowsList = tvShowsList {
                        self?.tvShowsList.onNext(tvShowsList)
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
