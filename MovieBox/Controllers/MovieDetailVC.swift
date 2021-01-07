//
//  MovieDetailVC.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    var selectedMovie: Movie?

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var lblMoviename: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblsinopsis: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.title = "MovieBox"
        self.lblMoviename.text = selectedMovie?.title
        self.lblReleaseDate.text = selectedMovie?.year
        self.lblLanguage.text = "Language: \(selectedMovie?.language ?? "Language: NA")"
        getDisplayImage()
    }

    
    // MARK: - Get image data
    private func getDisplayImage(){
        guard let posterString = selectedMovie?.posterImage else {return}
        let urlString = "https://image.tmdb.org/t/p/w300" + posterString
        guard let posterImageURL = URL(string: urlString) else {
            self.posterImg.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we remove old image
        self.posterImg.image = nil
        getImageDataFrom(url: posterImageURL)
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
