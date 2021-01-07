//
//  SimilarMovieCell.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class SimilarMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var lblMoviename: UILabel!
    
    private var urlString: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 8.0
        posterImage.layer.borderColor = UIColor.black.cgColor
        posterImage.layer.borderWidth = 1.0
    }
    
    func setCellWithValuesOf(_ movie: KindMovie) {
        self.lblMoviename.text = movie.title
        
        guard let posterPath = movie.poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterPath
        
        guard let posterImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we remove old image => here we need to use Image Cache for caching image  in optimise phase
        self.posterImage.image = nil
        getImageDataFrom(url: posterImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        WebService().getImageDataFrom(url: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self!.posterImage.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self!.posterImage.image = UIImage(named: "noImageAvailable")
            }
        }
    }
}
