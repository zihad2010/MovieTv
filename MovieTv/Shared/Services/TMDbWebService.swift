//
//  TMDbWebService.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

import Foundation
import RxSwift

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct Resource<T: Decodable> {
    let url: URL
    var httpMethod: HttpMethod = .get
}

class TMDbWebService {

    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest.requestWith(resource: resource)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
        }
    }
}
