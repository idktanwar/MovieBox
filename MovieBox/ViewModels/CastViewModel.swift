//
//  CastViewModel.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

class CastViewModel {
    
    private var apiService = WebService()
    private var castlists = [Cast]()
    
    func fetchCastData(forMovieId: Int, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getCastData(forMovieId: forMovieId) { [weak self] (result) in
        
        switch result {
        case .success(let listOf):
            self?.castlists = listOf.casts
            completion()
        case .failure(let error):
            // Something is wrong with the JSON
            print("Error processing json data: \(error)")
        }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if castlists.count != 0 {
            return castlists.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Cast {
        return castlists[indexPath.row]
    }
    
    var total: Int {
           return castlists.count
    }
}
