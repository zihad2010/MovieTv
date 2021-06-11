//
//  TMDbWebService.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import RxSwift

enum HttpMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
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
    case authorizationError(Data)
}

class TMDbWebService {
    
    static func load<T>(resource: Resource<T>) -> Observable<(ApiResult<T>)> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest.requestWith(resource: resource)
                return URLSession.shared.rx.response(request: request)
            }.map { response,data -> (ApiResult<T>) in
                
                switch response.statusCode {
                case 200...300:
                    do {
                        let data = try JSONDecoder().decode(T.self, from: data)
                        return ApiResult.success(data)
                    } catch  {
                        return ApiResult.failure(.unknownError)
                    }
                case 400...499:
                    return ApiResult.failure(.authorizationError(data))
                case 500...599:
                    return ApiResult.failure(.serverError)
                default:
                    return .failure(.unknownError)
                }
            }
    }
}
