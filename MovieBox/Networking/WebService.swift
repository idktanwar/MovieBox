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

    func getNewMoviesData(withoffset offset: Int , limit: Int, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let newMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(TMDB_API_KEY)&language=en-US&page=\(limit)"
        
        guard let url = URL(string: newMoviesURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
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
    
    
    func getImageDataFrom(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }
        dataTask?.resume()
    }
    
    
    
    func getCastData(forMovieId id: Int, completion: @escaping (Result<CastsData, Error>) -> Void)
    {
        let castDataURL = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(TMDB_API_KEY)&language=en-US"
        
        guard let url = URL(string: castDataURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CastsData.self, from: data)
                
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
    
    func getSimilarMoviesData(forMovieId id: Int, completion: @escaping (Result<RecommendedMoiveData, Error>) -> Void)
    {
        let castDataURL = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(TMDB_API_KEY)&language=en-US"
        
        guard let url = URL(string: castDataURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RecommendedMoiveData.self, from: data)
                
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
    
    
    func getVideoData(forMovieId id: Int, completion: @escaping (Result<VideoData, Error>) -> Void)
    {
        let videoDataURL = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(TMDB_API_KEY)&language=en-US"
        
        guard let url = URL(string: videoDataURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(VideoData.self, from: data)
                
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
