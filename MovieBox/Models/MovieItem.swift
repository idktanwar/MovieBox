//
//  MovieItem.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 09/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

struct MovieItem: Decodable {
    let id: Int
    let title: String?
    let year: String?
    let rate: Double
    let posterImage: String?
    let overview: String?
    let language: String?
    let genres: [Genre]
    let runtime: Int
    
    private enum CodingKeys: String, CodingKey {
        case title, overview, id, genres, runtime
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case language = "original_language"
    }
}

struct Genre: Decodable {
    let name: String
}

