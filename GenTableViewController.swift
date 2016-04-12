//
//  GenTableViewController.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/1/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import RealmSwift
class GenTableViewController: UITableViewController {
    let realm = try! Realm()
    let list = try! Realm().objects(WorkoutItem)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 16)!]
        self.navigationItem.title = "Saved Workouts"
        if list.count == 0 {
            let alert = UIAlertController(title: "Saved Workout is empty!", message: .None, preferredStyle: .Alert)
            let OK = UIAlertAction(title: "OK", style: .Default, handler: { (action:UIAlertAction) in
                self.navigationController?.popViewControllerAnimated(true)
            })
            alert.addAction(OK)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sCell", forIndexPath: indexPath)
        cell.textLabel?.text = list[indexPath.row].Name
        cell.detailTextLabel?.text = list[indexPath.row].date
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Trash") {
            (action, indexPath) -> Void in self.editing = false
            let toBeDeleted = self.list[indexPath.row]
            try! self.realm.write({ () -> Void in
                self.realm.delete(toBeDeleted)
            })
            tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor.redColor()
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit") {
            (action, indexPath) -> Void in self.editing = false
            var inputTextField: UITextField?
            let namePrompt = UIAlertController(title: "Enter new workout title:", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            namePrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            namePrompt.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                try! self.realm.write({
                    self.list[indexPath.row].Name = (inputTextField?.text)!
                })
                tableView.reloadData()
            }))
            namePrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "eg. Workout 1"
                inputTextField = textField
            })
            self.presentViewController(namePrompt, animated: true, completion: nil)
        }
        editAction.backgroundColor = UIColor.grayColor()
        return [deleteAction, editAction]
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "workoutSeg" {
            let upcoming = segue.destinationViewController as! WorkoutTableVC
            let indexPath = self.tableView.indexPathForSelectedRow
            upcoming.newWorkout = list[(indexPath?.row)!]
        }
    }
}
