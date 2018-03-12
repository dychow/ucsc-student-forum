//
//  ItemTableViewCell.swift
//  UCSCForum
//
//  Created by MacDouble on 1/24/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var personName: UILabel!

    @IBOutlet weak var itemNameTextField: UILabel!
    
    @IBOutlet weak var itemDetailTextField: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var contentImage: UIImageView!
    
    @IBOutlet weak var commentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.masksToBounds = true
        
        profileImage.layer.borderWidth = 0.5
        
        profileImage.layer.borderColor = UIColor.white.cgColor
        
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
