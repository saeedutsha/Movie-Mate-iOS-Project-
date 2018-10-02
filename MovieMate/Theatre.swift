//
//  Theatre.swift
//  MovieMate
//
//  Created by Utsha on 12/6/17.
//  Copyright © 2017 Utsha. All rights reserved.
//

import UIKit

class Theatre: UITableViewCell {

    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
