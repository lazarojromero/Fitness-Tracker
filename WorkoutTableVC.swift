//
//  WorkoutTableVC.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/2/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//
import UIKit
import RealmSwift
class WorkoutTableVC: UITableViewController {
    var newWorkout = WorkoutItem()
    let realm = try! Realm()
    //let list = try! Realm().objects(WorkoutItem)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.tableView.reloadInputViews()
        self.tableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        self.tableView.reloadInputViews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newWorkout.workoutList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuse", forIndexPath: indexPath) as! WorkoutTableViewCell
        cell.exLabel.text = newWorkout.workoutList[indexPath.row].Name
       // if newWorkout.workoutList.count != 0 {
            if(newWorkout.workoutList[indexPath.row].sets == "" || newWorkout.workoutList[indexPath.row].reps == ""){
                cell.setsLabel.text = "Sets: 4"
                cell.repsLabel.text = "Reps: 10"
                cell.maxLbl.text = "Max (lbs): --"
            } else {
                cell.setsLabel.text = "Sets: " + "\(newWorkout.workoutList[indexPath.row].sets)"
                cell.repsLabel.text = "Reps: " + "\(newWorkout.workoutList[indexPath.row].reps)"
                cell.maxLbl.text = "Max (lbs): " + "\(newWorkout.workoutList[indexPath.row].max)"
            }
        //}
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction] {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Trash") {
            (action, indexPath) -> Void in self.editing = false
            let toBeDeleted = self.newWorkout.workoutList[indexPath.row]
            try! self.realm.write({ () -> Void in
                self.realm.delete(toBeDeleted)
            })
            tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction]
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editSegue") {
            let upcoming = segue.destinationViewController as! EditViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            upcoming.ex = newWorkout.workoutList[(indexPath?.row)!]
        }
    }
}
