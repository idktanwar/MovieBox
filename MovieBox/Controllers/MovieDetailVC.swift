//
//  MovieDetailVC.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    //MARK: Properties
    var selectedMovie: Movie!
    var movieID: Int = 0
    private var castVM = CastViewModel()
    private var similarMovieVM = RecommondedMovieViewModel()

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var lblMoviename: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblsinopsis: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    @IBOutlet weak var lblSimilarMovie: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var similarmvCollectionView: UICollectionView!
    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.title = "Explore"
        
        self.fetchMovie()
        
        self.lblMoviename.text = selectedMovie?.title
        self.lblReleaseDate.text = Helper.app.convertDateFormater(selectedMovie?.year)
        self.lblLanguage.text = "\(selectedMovie?.language ?? "")"
        getDisplayImage(withPosterPath: selectedMovie?.posterImage)
        
        castCollectionView.delegate = self
        similarmvCollectionView.delegate = self

        fetchCastData()
        fetchSimilarMoviesData()
    }
    
    //MARK: Helper Methods
    private func fetchMovie() {
        let movieItemViewModel = MovieItemViewModel(movieID: movieID)
        movieItemViewModel.fetchMovieItem(url: movieItemViewModel.resourceURL) {
            [weak self] in
            DispatchQueue.main.async {
                self?.lblsinopsis.text = movieItemViewModel.synopsis
                self?.lblGenres.text = movieItemViewModel.genre
                self?.lblMovieTime.text = movieItemViewModel.movieTime
                self?.lblMoviename.text = movieItemViewModel.title
                self?.lblReleaseDate.text = Helper.app.convertDateFormater(movieItemViewModel.releasedate)
                self?.getDisplayImage(withPosterPath: movieItemViewModel.posterPath)
            }
        }
    }
    
    private func fetchCastData() {
        castVM.fetchCastData(forMovieId: movieID) { [weak self] in
            if self?.castVM.total == 0 {
                self?.lblCast.isHidden = true
            }
            self?.castCollectionView.dataSource = self
            self?.castCollectionView.reloadData()
        }
    }
    
    private func fetchSimilarMoviesData() {
        similarMovieVM.fetchSimilarMoviesData(forMovieId: movieID) { [weak self] in
            if self?.similarMovieVM.total == 0 {
                self?.lblSimilarMovie.isHidden = true
            }
            self?.similarmvCollectionView.dataSource = self
            self?.similarmvCollectionView.reloadData()
        }
    }
    
    // MARK: - Web Service Call
    
    private func getDisplayImage(withPosterPath posterString: String?){
        if let posterString = posterString, posterString.count > 0 {
            let urlString = "https://image.tmdb.org/t/p/w300" + posterString
            guard let posterImageURL = URL(string: urlString) else {
                self.posterImg.image = UIImage(named: "noImageAvailable")
                return
            }
            
            // Before we download the image we remove old image
            self.posterImg.image = nil
            getImageDataFrom(url: posterImageURL)
        }
        
    }
    
    private func getImageDataFrom(url: URL) {
        WebService().getImageDataFrom(url: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self!.posterImg.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self!.posterImg.image = UIImage(named: "noImageAvailable")
            }
        }
    }
    
}

//MARK: Tableview Delegate & DataSource

extension  MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.castCollectionView {
            return castVM.numberOfRowsInSection(section: section)
        }
        else {
            return similarMovieVM.numberOfRowsInSection(section: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.castCollectionView  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castcell", for: indexPath) as! CastCollectionCell

            let cast = castVM.cellForRowAt(indexPath: indexPath)
            cell.setCellWithValuesOf(cast)
            cell.updateConstraintsIfNeeded()
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarcell", for: indexPath) as! SimilarMovieCell
            let movie = similarMovieVM.cellForRowAt(indexPath: indexPath)
            cell.setCellWithValuesOf(movie)
            cell.updateConstraintsIfNeeded()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  collectionView == self.similarmvCollectionView {
            let similarMovie = similarMovieVM.cellForRowAt(indexPath: indexPath)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
            viewController.movieID = similarMovie.id
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

}


