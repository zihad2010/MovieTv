//
//  URL+Api.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

extension URL {
    static let baseUrl  = "https://api.themoviedb.org/3"
    static let photoBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "eb8aa6f914f794f711fb1841fb141f12"
}

extension URL {
    static let mvieListUrl                               = "\(URL.baseUrl)/discover/movie?api_key=\(apiKey)"
    static let tvShowsListUrl                               = "\(URL.baseUrl)/discover/tv?api_key=\(apiKey)"
    static let searchMovieUrl                        = "\(URL.baseUrl)/search/movie?api_key=\(apiKey)&query=Cruella"
    static let searchTvShowsUrl                        = "\(URL.baseUrl)/search/tv?api_key=\(apiKey)&query="
}

extension URL{
    static func convertUrl(urlStr: String) -> URL? {
      return URL(string: urlStr)
    }
}
