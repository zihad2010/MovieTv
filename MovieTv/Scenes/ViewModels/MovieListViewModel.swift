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
}

struct MovieViewModel {
    
    let result: Results
    
    init(_ result: Results) {
        self.result = result
    }
    
    var title: String {
        return result.name ?? ""
    }
    
    var poster_path: String {
        return result.poster_path ?? ""
    }
}
