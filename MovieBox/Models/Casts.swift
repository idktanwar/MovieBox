//
//  Casts.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

struct CastsData: Decodable {
    let casts: [Cast]
    
    private enum CodingKeys: String, CodingKey {
        case casts = "cast"
    }
}

struct Cast: Decodable {
    let name: String?
    let profile: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case profile = "profile_path"
    }
}
