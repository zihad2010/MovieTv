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
            self.error.onNext(.internetError("The Internet connection appears to be offline."))
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
                    if let tvShowsList = movieList{
                        self?.movieList.onNext(tvShowsList)
                    }
                    break
                case .failure(let error):
                    break
                }
            }, onError: {[weak self] (error) in
                self?.loading.onNext(false)
                print(error.localizedDescription)
                self?.error.onNext(.serverMessage(error.localizedDescription))
                print(error.localizedDescription)
            }).disposed(by: disposable)
        
        
    }
}

