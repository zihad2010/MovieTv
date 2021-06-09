//
//  URL+Api.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

extension URL {
    static let baseUrl  = "http://103.123.8.52:8010"
}

extension URL {
    static let login                               = "\(URL.baseUrl)/api/v1/auth/login/"
    static let logout                              = "\(URL.baseUrl)/api/v1/auth/logout"
    static let registration                        = "\(URL.baseUrl)/api/v1/auth/registration/"
}
