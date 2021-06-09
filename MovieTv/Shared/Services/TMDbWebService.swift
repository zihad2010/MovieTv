//
//  TMDbWebService.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    case nullData
    case data
    case offline
    case invalidURL
    case undefined
    
}

enum Result<T,H> {
    case success(T,H)
    case failure(H)
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias HandlerResult = Result<Data,Error>

struct Resource {
    let url: URL
    var authorization: String?
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension Resource{
    //    init(url: URL) {
    //        self.url = url
    //    }
}


class TMDbWebService {
    
    static func load(resource:Resource,completion:@escaping(HandlerResult)->Void )  {
        
        URLSession.shared.dataTask(with: URLRequest.requestWith(resource: resource)) {(data, reponse, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.offline))
                return
            }
            
            if let statusCode = reponse?.getStatusCode() {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                        print("json data: \(json)")
                    }
                }
                catch let error {
                    print("error in catch block")
                    print(error)
                }
            }
        }.resume()
    }
}
