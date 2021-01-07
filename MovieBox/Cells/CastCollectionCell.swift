//
//  CastCollectionCell.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class CastCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var prfileImgView: UIImageView!
    @IBOutlet weak var lblCastname: UILabel!
    
    private var urlString: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        prfileImgView.layer.cornerRadius = 8.0
        prfileImgView.layer.borderColor = UIColor.black.cgColor
        prfileImgView.layer.borderWidth = 1.0
    }
    
    func setCellWithValuesOf(_ cast: Cast) {
        self.lblCastname.text = cast.name
        
        guard let profileString = cast.profile else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + profileString
        
        guard let profileImageURL = URL(string: urlString) else {
            self.prfileImgView.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we remove old image => here we need to use Image Cache for caching image  in optimise phase
        self.prfileImgView.image = nil
        getImageDataFrom(url: profileImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        WebService().getImageDataFrom(url: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self!.prfileImgView.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self!.prfileImgView.image = UIImage(named: "noImageAvailable")
            }
        }
    }
}
