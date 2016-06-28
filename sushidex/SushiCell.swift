//
//  SushiCell.swift
//  sushidex
//
//  Created by Yuuya Masada on 4/19/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import UIKit
import CoreData

class SushiCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var counterLbl: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star6: UIImageView!
    @IBOutlet weak var star7: UIImageView!
    @IBOutlet weak var star8: UIImageView!
    @IBOutlet weak var star9: UIImageView!
    @IBOutlet weak var star10: UIImageView!
    @IBOutlet weak var star11: UIImageView!
    
    
    var sushi: Sushi!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0

        
    }
    
    func configureCell(sushi: Sushi) {

        self.sushi = sushi
        
        nameLbl.text = self.sushi.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.sushi.sushiId)")
        thumbImg.layer.magnificationFilter = kCAFilterNearest
        bgImg.layer.magnificationFilter = kCAFilterNearest
        
        let count = Sushi.currentCount("\(self.sushi.saveId)")
        checkStars()
      
        if count > 0 {
            counterLbl.text = "\(count)"
            counterLbl.hidden = false
        } else {
            counterLbl.hidden = true
        }

        

        
    }
    
    
    func checkStars() {
        
        star1.alpha = 0.05
        star2.alpha = 0.05
        star3.alpha = 0.05
        star4.alpha = 0.05
        star5.alpha = 0.05
        star6.alpha = 0.05
        star7.alpha = 0.05
        star8.alpha = 0.05
        star9.alpha = 0.05
        star10.alpha = 0.05
        star11.alpha = 0.0
        
        let count = Sushi.currentCount("\(self.sushi.saveId)")

        if count >= 10 {
            star1.alpha = 1.0
        }
        if count >= 20 {
            star2.alpha = 1.0
        }
        if count >= 30 {
            star3.alpha = 1.0
        }
        if count >= 40 {
            star4.alpha = 1.0
        }
        if count >= 50 {
            star5.alpha = 1.0
        }
        if count >= 60 {
            star6.alpha = 1.0
        }
        if count >= 70 {
            star7.alpha = 1.0
        }
        if count >= 80 {
            star8.alpha = 1.0
        }
        if count >= 90 {
            star9.alpha = 1.0
        }
        if count >= 100 {
            star10.alpha = 1.0
        }
        if count >= 110 {
            star11.alpha = 1.0
        }
        
    }

}
