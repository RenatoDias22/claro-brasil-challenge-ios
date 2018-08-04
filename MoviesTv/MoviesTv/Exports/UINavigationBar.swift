//
//  UINavigationBar.swift
//  MoviesTv
//
//  Created by Renato Dias on 04/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setTransparentBar() {
        let img = UIImage()
        self.shadowImage = img
        self.setBackgroundImage(img, for: .default)
        self.isTranslucent = true
    }
}

