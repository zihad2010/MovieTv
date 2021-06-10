//
//  ViewModelProtocol.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation

protocol ViewModelProtocol {
    func getResource() -> Resource<ResponseModel>
    func fetchDtaWith(resource: Resource<ResponseModel>)
}
