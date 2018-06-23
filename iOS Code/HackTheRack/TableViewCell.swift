//
//  TableViewCell.swift
//  HackTheRack
//
//  Created by KL on 23/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var backgroudView: UIView!
    @IBOutlet var type: UILabel!
    @IBOutlet var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        backgroudView.layer.cornerRadius = 5
        backgroudView.backgroundColor = UIColor(red: 75/255, green: 178/255,
                                                blue: 218/255, alpha: 1)
        backgroudView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch row {
        case 0:
            return "Red"
        case 1:
            return "Yellow"
        case 2:
            return "Green"
        case 3:
            return "Blue"
        case 4:
            return "Purple"
        case 5:
            return "While"
        case 6:
            return "Pink"
        default:
            return "Black"
        }
    }
}
