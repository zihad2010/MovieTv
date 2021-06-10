//
//  ResponseModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation

struct ResponseModel : Codable {
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?
}

struct Results : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let first_air_date : String?
    let genre_ids : [Int]?
    let id : Int?
    let name : String?
    let origin_country : [String]?
    let original_language : String?
    let original_name : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let vote_average : Double?
    let vote_count : Int?
    let release_date : String?
    let title : String?
    let video : Bool?
}
