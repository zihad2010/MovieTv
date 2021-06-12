//
//  TVShowsDetailsResponse.swift
//  MovieTv
//
//  Created by Asraful Alam on 12/6/21.
//

import Foundation

struct TVShowsDetailsResponse: Codable {
    let backdrop_path : String?
    let created_by : [Created_by]?
    let episode_run_time : [Int]?
    let first_air_date : String?
    let genres : [Genres]?
    let homepage : String?
    let id : Int?
    let in_production : Bool?
    let languages : [String]?
    let last_air_date : String?
    let last_episode_to_air : Last_episode_to_air?
    let name : String?
    let next_episode_to_air : Next_episode_to_air?
    let networks : [Networks]?
    let number_of_episodes : Int?
    let number_of_seasons : Int?
    let origin_country : [String]?
    let original_language : String?
    let original_name : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let production_companies : [Production_companies]?
    let production_countries : [Production_countries]?
    let seasons : [Seasons]?
    let spoken_languages : [Spoken_languages]?
    let status : String?
    let tagline : String?
    let type : String?
    let vote_average : Double?
    let vote_count : Int?

}

struct Created_by : Codable {
    let id : Int?
    let credit_id : String?
    let name : String?
    let gender : Int?
    let profile_path : String?
}

struct Last_episode_to_air : Codable {
    let air_date : String?
    let episode_number : Int?
    let id : Int?
    let name : String?
    let overview : String?
    let production_code : String?
    let season_number : Int?
    let still_path : String?
    let vote_average : Int?
    let vote_count : Int?
}

struct Next_episode_to_air : Codable {
    let air_date : String?
    let episode_number : Int?
    let id : Int?
    let name : String?
    let overview : String?
    let production_code : String?
    let season_number : Int?
    let still_path : String?
    let vote_average : Int?
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

struct Networks : Codable {
    let name : String?
    let id : Int?
    let logo_path : String?
    let origin_country : String?
}
