//
//  UIImageView.swift
//  MoviesTv
//
//  Created by Renato Dias on 05/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {

    func setImage(with url: URL!, placeholder: UIImage? = nil) {
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill)
        self.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.2))])
    }

}
