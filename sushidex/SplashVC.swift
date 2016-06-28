//
//  SplashVC.swift
//  sushidex
//
//  Created by Yuuya Masada on 4/19/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var logoBtn: UIButton!
    @IBOutlet weak var quoteLbl: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleArray = [UIImage]()
        
        for x in 0...22 {
            let img = UIImage(named: "5stitle_\(x).png")
            titleArray.append(img!)
        }
        
        titleImg.animationImages = titleArray
        titleImg.animationDuration = 2
        titleImg.animationRepeatCount = 0
        titleImg.startAnimating()
        
        logoBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        logoBtn.imageView?.layer.magnificationFilter = kCAFilterNearest
        
        quoteLbl.layer.magnificationFilter = kCAFilterNearest

   
        var quoteArray = [UIImage]()
        
        for _ in 0...5 {
            let randNum = arc4random_uniform(2);
            let img = UIImage(named: "quote_\(randNum).png")
            quoteArray.append(img!)
        }
        
        quoteLbl.animationImages = quoteArray
        quoteLbl.animationDuration = 10
        quoteLbl.animationRepeatCount = 0
        quoteLbl.startAnimating()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    



}
