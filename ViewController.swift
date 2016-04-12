//
//  ViewController.swift
//  NoleFit
//
//  Created by Lazaro Romero on 3/31/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UICollectionViewDelegate {
    var segueSelected = ""
    let sections = ["Build", "Generate", "Find A Gym", "Saved Workouts"]
    let icons = [UIImage(named:"cogwheel")!,UIImage(named:"random1")!, UIImage(named:"mapIcon")!, UIImage(named:"save1")!]
    let backgroundImages = [UIImage(named:"blue")!, UIImage(named:"section")!, UIImage(named:"grey")!, UIImage(named:"green")!]
//    let backgroundImages = [UIImage(named:"section")!, UIImage(named:"section")!, UIImage(named:"section")!, UIImage(named:"section")!]
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        exercises.removeAll()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MenuCollectionViewCell
        
        cell.iconImageView?.image = icons[indexPath.item]
        cell.sectionLabel?.text = sections[indexPath.item]
        cell.backgroundImageView?.image = backgroundImages[indexPath.item]
        cell.layer.cornerRadius = 8
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.row == 0 {
            performSegueWithIdentifier("BuildSegue", sender: self)
        } else if indexPath.row == 1 {
            performSegueWithIdentifier("GenSegue", sender: self)
        } else if indexPath.row == 2 {
            performSegueWithIdentifier("mapSegue", sender: self)
        } else {
            performSegueWithIdentifier("savedSection", sender: self)
        }
        return true
    }
}

