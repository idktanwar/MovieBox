//
//  MovieItemCell.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 06/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class MovieItemCell: UITableViewCell {

    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var rateStar: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    private var urlString: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentView.layer.cornerRadius = 8
//        contentView.layer.masksToBounds = true
//        contentView.layer.borderColor = UIColor.darkGray.cgColor
//        contentView.layer.borderWidth = 0.6
//
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.4
//        contentView.layer.shadowOffset = .zero
//        contentView.layer.shadowRadius = 2

        
//        self.layer.borderColor = UIColor.systemBlue.cgColor
//        self.layer.borderWidth = 5
//        self.layer.cornerRadius = 8.0
        
        playBtn.backgroundColor = UIColor.lightBlue1
        playBtn.setTitleColor(.white, for: .normal)
        playBtn.layer.cornerRadius = 8.0
       
        moviePoster.layer.cornerRadius = 4.0
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func PlayButtonPressed(_ sender: Any) {
        
    }
    
    // Setup movies values
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.lblMovieName.text = title
        self.lblReleaseDate.text = Helper.app.convertDateFormater(releaseDate)
        guard let rate = rating else {return}
        self.lblRating.text = String(rate)
        self.lblMovieOverview.text = overview
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we remove old image
        self.moviePoster.image = nil
        getImageDataFrom(url: posterImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        WebService().getImageDataFrom(url: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self!.moviePoster.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self!.moviePoster.image = UIImage(named: "noImageAvailable")
            }
        }
    }
    
}
