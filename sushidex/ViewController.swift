//
//  ViewController.swift
//  sushidex
//
//  Created by Yuuya Masada on 4/19/16.
//  Copyright © 2016 8bitsushi. All rights reserved.
//

import UIKit
import CoreData
import SpriteKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSushi: UIButton!
    @IBOutlet weak var filterOther: UIButton!
    @IBOutlet weak var filterRank: UIButton!
    @IBOutlet weak var pageLogo: UIImageView!
    @IBOutlet weak var homeBtn: UIButton!
    

    var sushi = [Sushi]()
    var filteredSushi = [Sushi]()
    var categorySushi = [Sushi]()
    var rankedSushi = [Sushi]()
    var orderByName = [Sushi]()
    var currentResults = [Sushi]()
    
    var inSearchMode = false
    var inSushiMode = false
    var sushiType: Int = 0
    var rankType: Int = 0

    var inOtherMode = false
    var inCategoryMode = false
    var inRankMode = false
    
    var items = [Items]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        parseSushiCSV()
        currentResults = sushi
        
        homeBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        homeBtn.imageView?.layer.magnificationFilter = kCAFilterNearest

        pageLogo.layer.magnificationFilter = kCAFilterNearest


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        sushi = []
        parseSushiCSV()
        
        sushiToggle(false)
        otherToggle(false)
        sortRank(false)
        
        collection.reloadData()


    }
   
    
    func parseSushiCSV() {
        let path = NSBundle.mainBundle().pathForResource("sushi", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let sushiId = Int(row["id"]!)!
                let name = row["identifier"]!
                let category = row["mcat"]!
                let subcategory = row["scat"]!
                let description = row["description"]!
                let english = row["english"]!
                let japanese = row["japanese"]!
                let saveId = row["sid"]!
                let counter = Sushi.currentCount("\(saveId)")

                let aSushi = Sushi(name: name, category: category, subcategory: subcategory, sushiId: sushiId, description: description, english: english, japanese: japanese, saveId: saveId, counter: counter)
                sushi.append(aSushi)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
   
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SushiCell", forIndexPath: indexPath) as? SushiCell {
            
            var aSushi: Sushi!
            
            if inSearchMode == true && inRankMode == false {
                aSushi = filteredSushi[indexPath.row]
                
            } else if inRankMode {
                aSushi = rankedSushi[indexPath.row]
                
            } else if inCategoryMode == true && inRankMode == false  {
                aSushi = categorySushi[indexPath.row]

            }  else if inCategoryMode == false && inRankMode == false  {
                aSushi = sushi[indexPath.row]
                
            } else {
                
                aSushi = sushi[indexPath.row]

            }
            
            cell.configureCell(aSushi)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var aSushi: Sushi!
        
        if inSearchMode {
            aSushi = filteredSushi[indexPath.row]
            
        } else if inRankMode {
            aSushi = rankedSushi[indexPath.row]
            
        } else if inCategoryMode == true && inRankMode == false  {
            aSushi = categorySushi[indexPath.row]
            
        } else if inCategoryMode == false && inRankMode == false  {
            aSushi = sushi[indexPath.row]
            
        } else {
            
            aSushi = sushi[indexPath.row]
            
        }
        
        performSegueWithIdentifier("SushiDetailVC", sender: aSushi)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredSushi.count
            
        } else if inRankMode {
            return rankedSushi.count
            
        } else if inCategoryMode == true && inRankMode == false  {
            return categorySushi.count
            
        } else if inCategoryMode == false && inRankMode == false  {
            return sushi.count
            
        } else {
            
            return sushi.count
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(90, 90)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
            
        } else {
            
           
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            
            if inCategoryMode == true && inRankMode == false {
                
                filteredSushi = categorySushi.filter({$0.name.rangeOfString(lower) != nil})
                
            } else if inRankMode == true {
                
                filteredSushi = categorySushi.filter({$0.name.rangeOfString(lower) != nil})
                
            } else {

                filteredSushi = sushi.filter({$0.name.rangeOfString(lower) != nil})
                
            }
       
            collection.reloadData()
            
        }
    }
    
    @IBAction func onPressedRank(sender: AnyObject) {
        inRankMode = true
        searchBar(searchBar, textDidChange: "")

        sortRank(inRankMode)
    }
    
    func sortRank(toggle: Bool) {

        
        if toggle == true {
            
            rankType = rankType + 1
            currentResults = currentUpdate()


        switch rankType {
                
        case 1:
            filterRank.setTitle("Top Ranked", forState: .Normal)
            filterRank.setTitleColor(UIColor.grayColor(), forState: .Normal)

            filterRank.backgroundColor = UIColor(red: 255/255, green: 213/255, blue: 0/255, alpha: 1)
            inRankMode = true
            
            rankedSushi = currentResults.sort { $0.counter > $1.counter }


        case 2:
            filterRank.setTitle("Low Ranked", forState: .Normal)
            filterRank.backgroundColor = UIColor(red: 230/255, green: 170/255, blue: 0/255, alpha: 0.8)
            inRankMode = true
            
            rankedSushi = currentResults.sort { $0.counter < $1.counter }

            
        default:
            filterRank.setTitle("Favorites", forState: .Normal)

            filterRank.setTitleColor(UIColor(red: 251/255, green: 232/255, blue: 174/255, alpha: 1), forState: .Normal)
            filterRank.backgroundColor = UIColor(red: 186/255, green: 158/255, blue: 78/255, alpha: 1)
            rankedSushi = sushi.sort { $0.sushiId < $1.sushiId }
            inRankMode = false
            rankType = 0
            break
        }
            
        } else {
            
            filterRank.setTitle("Favorites", forState: .Normal)
            filterRank.setTitleColor(UIColor(red: 251/255, green: 232/255, blue: 174/255, alpha: 1), forState: .Normal)
            filterRank.backgroundColor = UIColor(red: 186/255, green: 158/255, blue: 78/255, alpha: 1)
            rankedSushi = currentResults.sort { $0.sushiId < $1.sushiId }
            inRankMode = false
            rankType = 0

        }
        
    }
    
    func currentUpdate() -> [Sushi]{
        if inSearchMode {
            return filteredSushi
        } else if inCategoryMode  {
            return categorySushi
        } else {
            return sushi
        }
    }
    
    func sortName() {
        orderByName = sushi.sort { $0.name < $1.name }

    }
    
    
    
    @IBAction func onSushiPressed(sender: AnyObject) {

        inOtherMode = false
        otherToggle(inOtherMode)
        
        inRankMode = false
        sortRank(inRankMode)
        
        inSushiMode = true
        sushiToggle(inSushiMode)
        
    
        searchBar(searchBar, textDidChange: "")
        
        collection.reloadData()
    
    }

    
    @IBAction func onOtherPressed(sender: AnyObject) {

        inSushiMode = false
        sushiToggle(inSushiMode)
        
        inRankMode = false
        sortRank(inRankMode)
        
        inOtherMode = !inOtherMode
        otherToggle(inOtherMode)
        searchBar(searchBar, textDidChange: "")

        
        collection.reloadData()

    }
    
    func otherToggle(toggle: Bool) {
        
        if toggle == true {
            filterOther.setTitle("Other", forState: .Normal)
            filterOther.setTitleColor(UIColor.grayColor(), forState: .Normal)

            filterOther.backgroundColor = UIColor(red: 255/255, green: 213/255, blue: 0/255, alpha: 1)
            categorySushi = sushi.filter({$0.category.rangeOfString("Other") != nil})
            
            inCategoryMode = true
            
        } else {
            filterOther.backgroundColor = UIColor(red: 186/255, green: 158/255, blue: 78/255, alpha: 1)
            filterOther.setTitleColor(UIColor(red: 251/255, green: 232/255, blue: 174/255, alpha: 1), forState: UIControlState.Normal)

            
            inCategoryMode = false
            
            
        }
        
    }
    
    
    func sushiToggle(toggle: Bool) {
        
        if toggle == true {
            
            sushiType = sushiType + 1
            
            switch sushiType {
                
            case 1:
                filterSushi.setTitle("All Sushi", forState: .Normal)
                filterSushi.setTitleColor(UIColor.grayColor(), forState: .Normal)
                filterSushi.backgroundColor = UIColor(red: 255/255, green: 213/255, blue: 0/255, alpha: 1)
                
                categorySushi = sushi.filter({$0.category.rangeOfString("Sushi") != nil})
                
                inCategoryMode = true

                
            case 2:
                let type = "Nigiri"
                filterSushi.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                filterSushi.backgroundColor = UIColor(red: 230/255, green: 170/255, blue: 0/255, alpha: 0.8)
                setSubType(type)
                
            case 3:
                let type = "Gunkan"
                setSubType(type)
                
            case 4:
                let type = "Makimono"
                setSubType(type)
            
            case 5:
                let type = "Temaki"
                setSubType(type)
            
            case 6:
                let type = "Oshi"
                setSubType(type)
                
            case 7:
                let type = "Special Roll"
                setSubType(type)
                
            default:
                let type = "Sushi Type"
                filterSushi.setTitle(type, forState: .Normal)
                filterSushi.backgroundColor = UIColor(red: 186/255, green: 158/255, blue: 78/255, alpha: 1)
                filterSushi.setTitleColor(UIColor(red: 251/255, green: 232/255, blue: 174/255, alpha: 1), forState: UIControlState.Normal)
                categorySushi = sushi
                inCategoryMode = true
                sushiType = 0
                break
            }
            
        } else {
            filterSushi.setTitle("Sushi Type", forState: .Normal)
            filterSushi.backgroundColor = UIColor(red: 186/255, green: 158/255, blue: 78/255, alpha: 1)
            filterSushi.setTitleColor(UIColor(red: 251/255, green: 232/255, blue: 174/255, alpha: 1), forState: UIControlState.Normal)
            sushiType = 0
            inCategoryMode = true
            
        }
        
    }
    
    func setSubType(type: String) {
        
        inCategoryMode = true
        filterSushi.setTitle(type, forState: .Normal)

        categorySushi = sushi.filter({$0.subcategory.rangeOfString(type) != nil})

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SushiDetailVC"  {
            if let detailsVC = segue.destinationViewController as? SushiDetailVC {
                if let aSushi = sender as? Sushi {
                    detailsVC.sushi = aSushi

                }
            }
        }
    }

    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    

    
}

