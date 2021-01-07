//
//  RecommondedMovies.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

struct RecommendedMoiveData: Decodable {
    let recommondedMovies: [KindMovie]
    
    private enum CodingKeys: String, CodingKey {
        case recommondedMovies = "results"
    }
}

struct KindMovie: Decodable {
    let id: Int
    let title: String?
    let poster: String?

    private enum CodingKeys: String, CodingKey {
        case id, title
        case poster = "poster_path"
    }
}
