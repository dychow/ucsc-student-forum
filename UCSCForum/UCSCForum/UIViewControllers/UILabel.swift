//
//  UILabel.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 2/25/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

extension UILabel {
    var optimalHeight: CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y:0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
    }
}
