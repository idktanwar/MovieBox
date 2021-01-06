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
    @IBOutlet weak var lblMoviewName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CellView.layer.cornerRadius = 8
        CellView.layer.masksToBounds = true
        CellView.layer.borderColor = UIColor.darkGray.cgColor
        CellView.layer.borderWidth = 0.6
        
        playBtn.backgroundColor = UIColor.lightBlue1
        playBtn.setTitleColor(.white, for: .normal)
        playBtn.layer.cornerRadius = 8.0
        
        thumbnailImage.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        
    }

    @IBAction func PlayButtonPressed(_ sender: Any) {
        
    }
}
