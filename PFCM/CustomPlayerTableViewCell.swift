//
//  customPlayerTableViewCell.swift
//  PFCM
//
//  Created by Thomas Anderson on 19/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit

class CustomPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dob: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func circlePicture () {
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        self.profilePic.layer.borderColor = UIColor.green.cgColor
        self.profilePic.layer.borderWidth = 0.7
        self.profilePic.layer.shouldRasterize = true
    }


}
