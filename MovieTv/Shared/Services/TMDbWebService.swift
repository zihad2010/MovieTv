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

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
}

enum ApiResult<T> {
    case success(T)
    case failure(RequestError)
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}


class TMDbWebService {

    static func load<T>(resource: Resource<T>) -> Observable<(ApiResult<T>)> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest.requestWith(resource: resource)
                return URLSession.shared.rx.response(request: request)
            }.map { response,data -> (ApiResult<T>) in
                print("response:-",response.statusCode)
                //observer.onError(ApiResult.failure(.serverError) as! Error)
               // return (response, try JSONDecoder().decode(T.self, from: data))
                return ApiResult.success(try JSONDecoder().decode(T.self, from: data))
        }
    }
}
