//
//  TVShowsViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import Foundation
import RxSwift

class TVShowsListViewModel:ViewModelProtocol {
    
    private let disposable = DisposeBag()
    public let tvShowsList : PublishSubject<[EachItemViewModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
   
    func getResource() -> Resource<ResponseModel> {
        guard let url = URL.convertUrl(urlStr: URL.tvShowsListUrl) else {
            fatalError("URl was incorrect")
        }
        var resource = Resource<ResponseModel>(url: url)
        resource.httpMethod = .get
        return resource
    }
    
    func fetchDtaWith(resource: Resource<ResponseModel>) {
        guard Reachability.isConnectedToNetwork() else {
            self.error.onNext(.internetError("Check your Internet connection."))
            return
        }
        
        self.loading.onNext(true)
        TMDbWebService.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] response in
                self?.loading.onNext(false)
                switch response{
                case .success(let data):
                    let tvShowsList = data.results?.compactMap(EachItemViewModel.init)
                    if let tvShowsList = tvShowsList{
                        self?.tvShowsList.onNext(tvShowsList)
                    }
                    break
                case .failure(let error):
                    break
                }
            }, onError: {[weak self] (error) in
                self?.loading.onNext(false)
                self?.error.onNext(.serverMessage(error.localizedDescription))
                print(error.localizedDescription)
            }).disposed(by: disposable)
        
    }
}

struct TVShowsViewModel {
    
    let result: Results
    
    init(_ result: Results) {
        self.result = result
    }
    
    var title: String {
        return result.name ?? ""
    }
    
    var posterURL: URL? {
        if let path = result.poster_path {
            return URL(string: "\(URL.photoBaseUrl)\(path)")
        }
        return nil
    }
}
