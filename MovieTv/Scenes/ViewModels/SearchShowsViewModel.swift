//
//  SearchShowsViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import Foundation
import  RxSwift
import RxCocoa

class SearchShowsViewModel {
    
    
    private let disposable = DisposeBag()
    private var searchType: String? =  TMDbSearchingCollection(index: 0).map { $0.rawValue }
    public var segmentIndex = PublishRelay<Int>()
    public var searchText =  BehaviorRelay<String>(value: "")
    public let searchResultList : PublishSubject<[SearchResultCellVM]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ApiError> = PublishSubject()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        
        segmentIndex
            .asObservable()
            .subscribe(onNext: {[weak self] indx in
                print(indx)
                if let searchType = TMDbSearchingCollection(index: indx) {
                    self?.searchType = searchType.description
                }
            })
            .disposed(by: disposable)
        
        searchText
            .asObservable()
            .subscribe(onNext: {[weak self] text in
                if !text.isEmpty {
                    self?.fetchDtaWith(resource: (self?.getResource(type: (self?.searchType)!, query: text))!)
                }
            })
            .disposed(by: disposable)
    }
    
    func getResource(type:String,query: String) -> Resource<ResponseModel> {
        
        guard let url = URL.getSearchingUrl(type, query) else {
            fatalError("URl was incorrect")
        }
        var resource = Resource<ResponseModel>(url: url)
        resource.httpMethod = .get
        return resource
    }
    
}

extension SearchShowsViewModel {
   
    func fetchDtaWith(resource: Resource<ResponseModel>) {
        
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
            })
            .disposed(by: disposable)
    }
}

public enum TMDbSearchingCollection: String, CustomStringConvertible, CaseIterable {
    case movie
    case tv
   
    public init?(index: Int) {
        switch index {
        case 0:
            self = .movie
        case 1:
            self = .tv
        default:
            return nil
        }
    }
    
    public var description: String {
        switch self {
        case .movie:
            return "movie"
        case .tv:
            return "tv"
        }
    }
}
