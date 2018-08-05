//
//  MovieCollectionViewCell.swift
//  MoviesTv
//
//  Created by Renato Dias on 04/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImage(view: image)
    }
    
    private func setImage(view: UIImageView){
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2.5
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
    }
    
    func setImageView(_ movie: Movies) {
        if let url = movie.posterURL {
            self.image.setImage(with: url, placeholder: image.image)
        }
    }
}
