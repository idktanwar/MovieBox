//
//  Videos.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

struct VideoData: Decodable {
    let videos: [Video]
    
    private enum CodingKeys: String, CodingKey {
        case videos = "results"
    }
}

struct Video: Decodable {
    let key: String
    let id: String
    let site: String?
    let size: Int
}
