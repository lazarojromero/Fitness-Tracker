//
//  SaveTableViewController.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/1/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import RealmSwift
class SaveTableViewController: UITableViewController {
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"save"), style: .Plain, target: self, action: #selector(SaveTableViewController.saveTapped))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("saveCell", forIndexPath: indexPath) as! SaveTableViewCell
        cell.saveLabel.text = exercises[indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        cell.cellButton.tag = indexPath.row
        cell.onButtonTouched = {
            var res = ""
            let white = cell.saveLabel.text!.characters.filter { !" \n\t\r".characters.contains($0)}
            for i in 0 ..< white.count {
                res = res + "\(white[i])"
            }
            let url = NSURL(fileURLWithPath:"/Users/LazaroRomero/Desktop/NoleFit/NoleFit/" + "\(res)" + ".mp4")
            self.playerView = AVPlayer(URL: url)
            self.playerViewController.player = self.playerView
            self.presentViewController(self.playerViewController, animated: true) {
                self.playerViewController.player?.play()
            }
        }
        return cell
    }
    func saveTapped() {
        let newWorkout = WorkoutItem()
        do {
            let realm = try! Realm()
            try realm.write({
                let def = NSDate()//default name
                let date = NSDate()
                let dateFormatter = NSDateFormatter()
                dateFormatter.locale = NSLocale.currentLocale()
                dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
                let newDate = dateFormatter.stringFromDate(date)
                newWorkout.Name = "\(def)"
                newWorkout.date = "\(newDate)"
                realm.add(newWorkout)
                for name in exercises {
                    let list = Exercise()
                    list.Name = name
                    newWorkout.workoutList.append(list)
                }
            })
        } catch {
            print("Error storing to Realm Database")
        }
        exercises.removeAll()
        navigationController?.popViewControllerAnimated(true)
    }
}
