//
//  CeachItemViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import Foundation

struct EachItemViewModel {
    
    var title: String?
    var posterURL: URL?
    var  id: Int?
    
    init(_ result: Results) {
        
        self.id = result.id
        self.title = result.title ?? result.name ?? ""
        if let path = result.poster_path{
            self.posterURL = URL(string: "\(URL.photoBaseUrl)\(path)")
        }
    }
}
