//
//  CeachItemViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import Foundation

struct EachItemViewModel {
    
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
    
    var posterURL: URL? {
        if let path = result.poster_path {
            return URL(string: "\(URL.photoBaseUrl)\(path)")
        }
        return nil
    }
}
