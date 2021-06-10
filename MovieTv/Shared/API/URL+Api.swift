//
//  URL+Api.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

extension URL {
    static let baseUrl  = "https://api.themoviedb.org/3/discover"
    static let photoBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "eb8aa6f914f794f711fb1841fb141f12"
}

extension URL {
    static let mvieListUrl                               = "\(URL.baseUrl)/movie?api_key=\(apiKey)"
    static let tvShowsListUrl                               = "\(URL.baseUrl)/tv?api_key=\(apiKey)"
    static let registration                        = "\(URL.baseUrl)/api/v1/auth/registration/"
}

extension URL{
    static func convertUrl(urlStr: String) -> URL? {
      return URL(string: urlStr)
    }
}
