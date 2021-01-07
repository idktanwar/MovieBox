//
//  WebService.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 06/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

class WebService {
    
    private var dataTask: URLSessionDataTask?

    
//    func getMovies(url: URL, completion: @escaping ([Movie]?) -> ()) {
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil)
//            }
//            else if let data = data {
//
//                let moviesList = try? JSONDecoder().decode(MoviesList.self, from: data)
//
//                if let moviesList = moviesList {
//                    completion(moviesList.results)
//                }
//
//                print(moviesList!.results)
//
//            }
//
//        }.resume()
//
//    }
    
    
    func getNewMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let newMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=53e8379e33e80a5fa41a392d98e5a878&language=en-US&page=1"
        
        guard let url = URL(string: newMoviesURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                return
            }
            print("status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
