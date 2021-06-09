//
//  URLResponse+Extension.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

extension URLResponse {

    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
