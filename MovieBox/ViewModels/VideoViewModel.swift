//
//  VideoViewModel.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

class VideoViewModel {
    
    private var apiService = WebService()
    private var videos = [Video]()
    
    func fetchVideoData(forMovieId: Int, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getVideoData(forMovieId: forMovieId) { [weak self] (result) in
        
        switch result {
        case .success(let listOf):
            self?.videos = listOf.videos
            completion()
        case .failure(let error):
            // Something is wrong with the JSON
            print("Error processing json data: \(error)")
        }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if videos.count != 0 {
            return videos.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Video {
        return videos[indexPath.row]
    }
}
