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
}

extension URL{
    static func convertUrl(urlStr: String) -> URL? {
      return URL(string: urlStr)
    }
}

extension URL {
    static func getSearchingUrl(_ type:String,_ query:String)-> URL? {
        var url = convertUrl(urlStr: "\(URL.baseUrl)/search/\(type)?api_key=\(apiKey)")
        url?.appendQueryItem(name: "query", value: query)
        return url
    }
}

extension URL {
    
    mutating func appendQueryItem(name: String, value: String?) {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        self = urlComponents.url!
    }
}
