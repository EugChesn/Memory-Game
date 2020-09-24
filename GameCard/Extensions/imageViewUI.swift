//
//  imageViewUI.swift
//  GameCard
//
//  Created by Евгений on 24.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

extension UIImageView {
    func cornerRadius() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
