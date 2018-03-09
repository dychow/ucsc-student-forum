//
//  DetailTableViewCell.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/3/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commenterProfileImage: UIImageView!
    
    @IBOutlet weak var commenterNameTextField: UILabel!
    
    @IBOutlet weak var commentDetailTextField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
