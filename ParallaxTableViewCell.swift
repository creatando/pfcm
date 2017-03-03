//
//  ParallaxCollectionViewCell.swift
//  PFCM
//
//  Created by Thomas Anderson on 03/03/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit

class ParallaxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parallaxImageView: UIImageView!
    
    // MARK: ParallaxCell
    
    @IBOutlet weak var parallaxHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var parallaxTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //clipsToBounds = true
        parallaxImageView.contentMode = .scaleAspectFill
        //parallaxImageView.clipsToBounds = false
    }
    
    
}
