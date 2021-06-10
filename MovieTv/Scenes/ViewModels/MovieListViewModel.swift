//
//  MovieListViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation
import RxSwift

class MovieListViewModel {
    
    private let disposable = DisposeBag()
    public let MovieList : PublishSubject<[MovieViewModel]> = PublishSubject()
   
    
   
//    let movieList: [MovieViewModel]
//    init(_ articles: [Results]) {
//        self.movieList = articles.compactMap(MovieViewModel.init)
//    }
    
    func fetchDtaWith(resource: Resource<MovieResponseModel>) {
        
        TMDbWebService.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] response in
                
                let movieList = response.results?.compactMap(MovieViewModel.init)
                if let movieList = movieList{
                    self?.MovieList.onNext(movieList)
                }
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposable)
        
    }
}

struct MovieViewModel {
    
    let result: Results
    
    init(_ result: Results) {
        self.result = result
    }
    
    var title: String {
        return result.name ?? ""
    }
    
    var posterURL: URL? {
        if let path = result.poster_path {
            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        }
        return nil
    }
    
}
