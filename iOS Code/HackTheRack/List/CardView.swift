//
//  CardView.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import Material
import Kingfisher

protocol CardViewDelegate {
    func didLikePlant()
    func didDislikePlant()
}

class CardView: UIView{

    @IBOutlet var contentView: UIView!
    @IBOutlet var likeButton: IconButton!
    @IBOutlet var dislikeButton: IconButton!
    @IBOutlet var titileLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailView: UIView!
    
    var delegate: CardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = false
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        detailView.layer.cornerRadius = 15
        detailView.clipsToBounds = true
        
        likeButton.pulseColor = UIColor.white
        likeButton.backgroundColor = UIColor.appGreenColor()
        likeButton.image = Icon.favoriteBorder
        likeButton.tintColor = UIColor.white
        dislikeButton.pulseColor = UIColor.white
        dislikeButton.backgroundColor = UIColor.red
        dislikeButton.image = Icon.cm.close
        dislikeButton.tintColor = UIColor.white
        
        shadowView.layer.cornerRadius = 15
        shadowView.clipsToBounds = true
    }
    
    @IBAction func buttonOnClick(_ sender: IconButton) {
        if sender == likeButton{
            delegate?.didLikePlant()
        }else if sender == dislikeButton{
            delegate?.didDislikePlant()
        }
    }
}
