//
//  UIImage+Image.swift
//  MovieTv
//
//  Created by Asraful Alam on 13/6/21.
//

import Foundation

extension UIImage {
    static let largePlaceHolder = getImage(string: "LargePlaceHolder")
    static let thumbPlaceHolder = getImage(string: "ThumbPlaceHolder")
    static let unselectedMovie = getImage(string: "unselectedMovie")
    static let selectedMovie = getImage(string: "selectedMovie")
    static let unselectedSearch = getImage(string: "unselectedSearch")
    static let selectedSearch = getImage(string: "selectedSearch")
    static let unselectedTv = getImage(string: "unselectedTv")
    static let selectedTv = getImage(string: "selectedTv")
    
}

extension UIImage {
    private static func getImage(string: String) -> UIImage {
        return UIImage(named: string) ?? UIImage()
    }
}
