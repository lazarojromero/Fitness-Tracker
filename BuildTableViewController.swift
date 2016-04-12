//
//  BuildTableViewController.swift
//  NoleFit
//  Created by Lazaro Romero on 3/31/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
var exercises: [String] = []
class BuildTableViewController: UITableViewController {
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    var temp:[String] = []
    var naviTitle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        temp.sortInPlace()
        self.navigationItem.title = naviTitle
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cel", forIndexPath: indexPath) as! BuildTableViewCell
        cell.cellLabel.font = UIFont(name: "Avenir", size: 16)!
        cell.cellLabel.text = temp[indexPath.row]
        cell.cellButton.tag = indexPath.row
        cell.onButtonTouched = {
            var res = ""
            let white = cell.cellLabel.text!.characters.filter { !" \n\t\r".characters.contains($0) }
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BuildTableViewCell
        if cell.accessoryType == .None {
            cell.accessoryType = .Checkmark
            exercises.append(temp[indexPath.row])
        } else if cell.accessoryType == .Checkmark {
            cell.accessoryType = .None
            let index = exercises.indexOf(temp[indexPath.row])
            exercises.removeAtIndex((index)!)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
//    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BuildTableViewCell
//        var res = ""
//        let white = cell.cellLabel.text!.characters.filter { !" \n\t\r".characters.contains($0)}
//        for i in 0 ..< white.count {
//            res = res + "\(white[i])"
//        }
//        let url = NSURL(fileURLWithPath:"/Users/LazaroRomero/Desktop/NoleFit/NoleFit/" + "\(res)" + ".mp4")
//        playerView = AVPlayer(URL: url)
//        playerViewController.player = playerView
//        self.presentViewController(playerViewController, animated: true) { 
//            self.playerViewController.player?.play()
//        }
//    }
}