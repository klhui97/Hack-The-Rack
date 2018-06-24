//
//  TableViewCell.swift
//  HackTheRack
//
//  Created by KL on 23/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var backgroundVie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        backgroundVie.layer.cornerRadius = 5
        backgroundVie.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
