//
//  ViewModelProtocol.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation

protocol ViewModelProtocol {
    func getResource<T>(value: T.Type) -> Any
    func fetchDtaWith<T>(resource:Resource<T>)
}
