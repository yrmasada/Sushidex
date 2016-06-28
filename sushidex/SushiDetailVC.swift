//
//  SushiDetailVC.swift
//  sushidex
//
//  Created by Yuuya Masada on 4/19/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import UIKit
import CoreData

class SushiDetailVC: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    var sushi: Sushi!
    var sushiCount: Int!
    var sushiNotes: String!
    var timer: NSTimer!
    var countDown: Int!
    
    var showingBack = true
    
    
    @IBOutlet weak var fillerStack: UIStackView!
    
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var bgImg: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var englishLbl: UITextView!
    @IBOutlet weak var japaneseLbl: UITextView!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var pageLogo: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mainBtn: UIButton!
    
    @IBOutlet weak var secondaryBtn: UIButton!
    
    @IBOutlet weak var sushiBg: UIImageView!
    @IBOutlet weak var notesLbl: UITextView!
    @IBOutlet weak var descriptionLbl: UITextView!
    
    @IBOutlet weak var nameLblBg: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var saveDoneLbl: UITextField!
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(sushi.sushiId)")
        mainBtn.setImage(img, forState: .Normal)
        
        mainBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        mainBtn.imageView?.layer.magnificationFilter = kCAFilterNearest
        self.view.addConstraint(NSLayoutConstraint(item: mainBtn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: mainBtn, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: mainBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20.0))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryBtn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryBtn, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20.0))
        
        secondaryBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        secondaryBtn.imageView?.layer.magnificationFilter = kCAFilterNearest

        
        sushiBg.layer.magnificationFilter = kCAFilterNearest
        backBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        backBtn.imageView?.layer.magnificationFilter = kCAFilterNearest
        pageLogo.layer.magnificationFilter = kCAFilterNearest
        
        resetBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        resetBtn.imageView?.layer.magnificationFilter = kCAFilterNearest


        
        notesLbl.layer.cornerRadius = 5.0
        englishLbl.layer.cornerRadius = 5.0
        japaneseLbl.layer.cornerRadius = 5.0
        descriptionLbl.layer.cornerRadius = 5.0
        resetBtn.layer.cornerRadius = 3.0
        saveBtn.layer.cornerRadius = 5.0
        bgImg.layer.cornerRadius = 5.0
        nameLblBg.layer.cornerRadius = 3.0



        nameLbl.text = sushi.name.capitalizedString
        englishLbl.text = sushi.english.capitalizedString
        japaneseLbl.text = sushi.japanese.capitalizedString
        descriptionLbl.text = sushi.description
        sushiCount = currentCount()
        counterLbl.text = "\(sushiCount)"
        sushiNotes = currentNotes()
        notesLbl.text = "\(sushiNotes)"
        notesLbl.delegate = self
        
        star1.layer.magnificationFilter = kCAFilterNearest
        star2.layer.magnificationFilter = kCAFilterNearest
        star3.layer.magnificationFilter = kCAFilterNearest
        star4.layer.magnificationFilter = kCAFilterNearest
        star5.layer.magnificationFilter = kCAFilterNearest
        star6.layer.magnificationFilter = kCAFilterNearest
        star7.layer.magnificationFilter = kCAFilterNearest
        star8.layer.magnificationFilter = kCAFilterNearest
        star9.layer.magnificationFilter = kCAFilterNearest
        star10.layer.magnificationFilter = kCAFilterNearest
        star11.layer.magnificationFilter = kCAFilterNearest


        
        checkStars()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SushiDetailVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SushiDetailVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            print("Keyboard shown")

            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -20 + keyboardSize.height)

                bottomHeight.constant = keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification){

        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0)
        
        bottomHeight.constant = 0
        
        print("Keyboard hidden")
            

    }

    
    @IBAction func minusBtnPressed(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: moc)
        
        
        print("Before Check: \(checkRecordsOk)")
        let check = checkRecordsOk("\(sushi.saveId)")
        print("After Check: \(checkRecordsOk)")
        
        
        if check == 0 {
            
            newUser.setValue("\(sushi.saveId)", forKey: "sid")
            newUser.setValue(1, forKey: "counter")
            newUser.setValue("First notes", forKey: "notes")
            
            do {
                try moc.save()
                print("saved newUser: \(newUser)")
                updateCounter(0)
                
            } catch {
                print("Unable to save managed object context.")
            }
            
        } else {
            print("already exists")
            sushiCount = minusCount("\(sushi.saveId)") as Int!
            updateCounter(sushiCount)
            checkStars()
            
            print("func sushiCount: \(sushiCount)")
        }
        
    }


    func counterBtnPressed() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: moc)
        
        
        print("Before Check: \(checkRecordsOk)")
        let check = checkRecordsOk("\(sushi.saveId)")
        print("After Check: \(checkRecordsOk)")

        
        if check == 0 {
            
            newUser.setValue("\(sushi.saveId)", forKey: "sid")
            newUser.setValue(1, forKey: "counter")
            newUser.setValue("First notes", forKey: "notes")
        
        do {
            try moc.save()
            print("saved newUser: \(newUser)")
            updateCounter(1)
            
        } catch {
            print("Unable to save managed object context.")
        }
            
        } else {
            print("already exists")
            sushiCount = addCount("\(sushi.saveId)") as Int!
            updateCounter(sushiCount)
            checkStars()
            
            print("func sushiCount: \(sushiCount)")
        }
        
        
        
    }
    
    
    
    @IBAction func buttonDown(sender: AnyObject) {
        countDown = 1

        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(SushiDetailVC.pressedTouch), userInfo: nil, repeats: true)

    }
    

    
    @IBAction func buttonUp(sender: AnyObject) {
        timer.invalidate()
        
        if countDown > 0 {
            print("early cancel")
            flipImage()
            countDown = 1
            
        } else {
            countDown = 1
        }
        
    }
    
    
    func pressedTouch() {
        
        if countDown > 0 {
            countDown = countDown - 1
            print("counting: \(countDown)")

        } else {
            print("done once")
            counterBtnPressed()
            blinkScreen()
            timer.invalidate()

        }
    }
    
//    FLIP IMAGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    func flipImage() {
        if (showingBack) {
            UIView.transitionFromView(mainBtn, toView: secondaryBtn, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            showingBack = false
            secondaryBtn.hidden = false

            self.view.addConstraint(NSLayoutConstraint(item: secondaryBtn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10.0))
            self.view.addConstraint(NSLayoutConstraint(item: secondaryBtn, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10.0))
            self.view.addConstraint(NSLayoutConstraint(item: secondaryBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20.0))

        } else {
            UIView.transitionFromView(secondaryBtn, toView: mainBtn, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            showingBack = true
            secondaryBtn.hidden = true

            self.view.addConstraint(NSLayoutConstraint(item: mainBtn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10.0))
            self.view.addConstraint(NSLayoutConstraint(item: mainBtn, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10.0))
            self.view.addConstraint(NSLayoutConstraint(item: mainBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.flipView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20.0))
        }
        
    }
    
    
    
    
    @IBAction func noteBtnPressed(sender: AnyObject) {
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: moc)
        
        
        print("Before Check: \(checkRecordsOk)")
        let check = checkRecordsOk("\(sushi.saveId)")
        print("After Check: \(checkRecordsOk)")
        
        
        if check == 0 {
            
            newUser.setValue("\(sushi.saveId)", forKey: "sid")
            newUser.setValue("Second notes", forKey: "notes")
            
            do {
                try moc.save()
                print("saved newUser: \(newUser)")
                updateNotes()
                
            } catch {
                print("Unable to save managed object context.")
            }
            
        } else {
            print("too many dups")
            addNotes("\(notesLbl.text)")
            
            print("func sushiCount: \(sushiCount)")
        }
        
    }
    

    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    
    func updateNotes() {
        notesLbl.text = "\(currentNotes())"
        
    }
    
    
    func addNotes(newNotes: String) -> String {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "sid == %@", "\(sushi.saveId)")
        
        fetchRequest.predicate = predicate
        

        
        do {
            
            let response = try moc.executeFetchRequest(fetchRequest)
            
            for result in response as! [NSManagedObject] {
                
                let oldNotes = result.valueForKey("notes") as! String
                print("OLD NOTES!!!: \(oldNotes)")
                let newNotes: String = notesLbl.text
                
            
                result.setValue("\(newNotes)", forKey: "notes")
                
                do {
                    try moc.save()
                    blinkScreen()
                    showSave()
                } catch {
                    print("Unable to save managed object context.")
                }
                
                return result.valueForKey("notes") as! String
                
            }
            
            print("response: \(response)")
            
        } catch let error as NSError {
            print(error)
        }
        
        return ""
        
    }
    
    func blinkScreen() {
        let wnd = UIApplication.sharedApplication().keyWindow;
        let v = UIView(frame: CGRectMake(0, 0, wnd!.frame.size.width, wnd!.frame.size.height))
        wnd!.addSubview(v);
        v.backgroundColor = UIColor.whiteColor()
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)
        v.alpha = 0.0;
        UIView.commitAnimations();
        

    }
    
    func showSave() {
        saveDoneLbl.hidden = false
        UIView.transitionWithView(saveDoneLbl, duration: 0.1 , options: [.TransitionCrossDissolve], animations: {self.saveDoneLbl.alpha = 20.0;
        

            
            }, completion: nil)
        
        UIView.transitionWithView(self.saveDoneLbl, duration: 2.5 , options: [.TransitionCrossDissolve], animations: {self.saveDoneLbl.alpha = 0.0 }, completion: nil)

        
        
    }
    
    

    @IBAction func btnLoad(sender: AnyObject) {

        
    }
    

    
    func checkRecordsOk(sid: String) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Items")
        let predicate = NSPredicate(format: "sid == %@", "\(sushi.saveId)")
        fetchRequest.predicate = predicate
        print("search case sushi.saveId: \(sushi.saveId)")
        print("predicate sid: \(sid)")
        print("fetch request 1: \(fetchRequest)")
        
        do {
            let result = try moc.executeFetchRequest(fetchRequest)
            print("result: \(result) \(result.count)")
            return result.count
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        print("didn't count so 1")
        return 1
    }
    
    func currentCount() -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "sid == %@", "\(sushi.saveId)")
        
        fetchRequest.predicate = predicate
        
        
        do {
            
            let response = try moc.executeFetchRequest(fetchRequest)
            
            for result in response as! [NSManagedObject] {
                
                let currentCount = result.valueForKey("counter") as! Int
                
                return currentCount
                
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        return 0
    }
    
    func checkStars() {
        
        star1.alpha = 0.1
        star2.alpha = 0.1
        star3.alpha = 0.1
        star4.alpha = 0.1
        star5.alpha = 0.1
        star6.alpha = 0.1
        star7.alpha = 0.1
        star8.alpha = 0.1
        star9.alpha = 0.1
        star10.alpha = 0.1
        star11.alpha = 0.0
        
        if currentCount() >= 10 {
            star1.alpha = 1.0
        }
        if currentCount() >= 20 {
            star2.alpha = 1.0
        }
        if currentCount() >= 30 {
            star3.alpha = 1.0
        }
        if currentCount() >= 40 {
            star4.alpha = 1.0
        }
        if currentCount() >= 50 {
            star5.alpha = 1.0
        }
        if currentCount() >= 60 {
            star6.alpha = 1.0
        }
        if currentCount() >= 70 {
            star7.alpha = 1.0
        }
        if currentCount() >= 80 {
            star8.alpha = 1.0
        }
        if currentCount() >= 90 {
            star9.alpha = 1.0
        }
        if currentCount() >= 100 {
            star10.alpha = 1.0
        }
        if currentCount() >= 110 {
            star11.alpha = 1.0
        }

    }
    
    
    func currentNotes() -> String {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "sid == %@", "\(sushi.saveId)")
        
        fetchRequest.predicate = predicate
        
        
        do {
            
            let response = try moc.executeFetchRequest(fetchRequest)
            
            for result in response as! [NSManagedObject] {
                
                let currentNotes = result.valueForKey("notes") as! String
                
                return currentNotes
                
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        return "Tap to edit notes"
    }
    
    func updateCounter(newCount: Int) {
        counterLbl.text = "\(newCount)"
        
    }
    
    func addCount(sid: String) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false

        let predicate = NSPredicate(format: "sid == %@", "\(sushi.saveId)")

        fetchRequest.predicate = predicate
        
        
        do {
            
            let response = try moc.executeFetchRequest(fetchRequest)
            
            for result in response as! [NSManagedObject] {
                
                let oldCount = result.valueForKey("counter") as! Int
                var newCount: Int = oldCount + 1
                
                if newCount == 1000 {
                    newCount = 999
                } else {
                
                print("newCount: \(newCount)")
                
                result.setValue(newCount, forKey: "counter")
                print("final count: \(result.valueForKey("counter"))")
                
                do {
                    try moc.save()
                    
                } catch {
                    print("Unable to save managed object context.")
                }
                
                return result.valueForKey("counter") as! Int
                    
                }
                
            }
            
            print("response: \(response)")

        } catch let error as NSError {
            print(error)
        }

            return 0
        
    }
    
    func minusCount(sid: String) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "sid == %@", "\(sushi.saveId)")
        
        fetchRequest.predicate = predicate
        
        
        do {
            
            let response = try moc.executeFetchRequest(fetchRequest)
            
            for result in response as! [NSManagedObject] {
                
                let oldCount = result.valueForKey("counter") as! Int
                var newCount: Int = oldCount - 1
                
                if newCount < 0 {
                    
                    newCount = 0
                    
                } else {
                
                print("newCount: \(newCount)")
                
                result.setValue(newCount, forKey: "counter")
                print("final count: \(result.valueForKey("counter"))")
                
                do {
                    try moc.save()
                    
                } catch {
                    print("Unable to save managed object context.")
                }
                
                return result.valueForKey("counter") as! Int
                    
                }
                
            }
            
            print("response: \(response)")
            
        } catch let error as NSError {
            print(error)
        }
        
        return 0
        
    }



    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    


}
