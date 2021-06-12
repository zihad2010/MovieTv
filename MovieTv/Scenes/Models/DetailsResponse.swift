//
//  MovieDetailsResponse.swift
//  MovieTv
//
//  Created by Asraful Alam on 12/6/21.
//

import Foundation

struct DetailsResponse: Codable {
    let adult : Bool?
    let backdrop_path : String?
    let episode_run_time : [Int]?
    let budget : Int?
    let genres : [Genres]?
    let homepage : String?
    let id : Int?
    let imdb_id : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let production_companies : [Production_companies]?
    let production_countries : [Production_countries]?
    let release_date : String?
    let revenue : Int?
    let runtime : Int?
    let spoken_languages : [Spoken_languages]?
    let status : String?
    let tagline : String?
    let title : String?
    let original_name : String?
    let first_air_date : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?
}

struct Seasons : Codable {
    let air_date : String?
    let episode_count : Int?
    let id : Int?
    let name : String?
    let overview : String?
    let poster_path : String?
    let season_number : Int?
}

struct Belongs_to_collection : Codable {
    let id : Int?
    let name : String?
    let poster_path : String?
    let backdrop_path : String?
}
struct Spoken_languages : Codable {
    let english_name : String?
    let iso_639_1 : String?
    let name : String?
}

struct Production_countries : Codable {
    let iso_3166_1 : String?
    let name : String?
}

struct Production_companies : Codable {
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?
}

struct Genres : Codable {
    let id : Int?
    let name : String?
}
