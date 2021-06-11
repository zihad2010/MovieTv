//
//  SearchShowsViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import Foundation
import  RxSwift

class SearchShowsViewModel : ViewModelProtocol{
    
    private let disposable = DisposeBag()
    public let searchResultList : PublishSubject<[SearchResultCellVM]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ApiError> = PublishSubject()
    
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
                    let searchResult = data.results?.compactMap(SearchResultCellVM.init)
                    if let searchResult = searchResult {
                        self?.searchResultList.onNext(searchResult)
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



struct SearchResultCellVM {
    
    let result: Results
    
    init(_ result: Results) {
        self.result = result
    }
    
    var title: String {
       
        if let title = result.title {
            return title
        }else{
            return result.name ?? ""
        }
    }
    
    var overview: String {
        return result.overview ?? ""
    }
    
    var posterURL: URL? {
        if let path = result.poster_path {
            return URL(string: "\(URL.photoBaseUrl)\(path)")
        }
        return nil
    }
}
