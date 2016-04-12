//
//  BuildCollectionViewController.swift
//  NoleFit
//
//  Created by Lazaro Romero on 3/31/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class BuildCollectionViewController: UICollectionViewController {
    var selected = 0
    var buildArray = [String]()
    let bodyParts:[String:[String]] = [
        "Chest": ["Hand Release PushUps", "Cable Fly", "Incline Dumbbell Press", "Dips", "Decline Dumbbell Bench Press", "Close Grip Bench Press", "Butterfly", "Bent Arm Dumbbell Pullover", "Barbell Incline Bench", "Pushups", "Dumbbell Flyes", "Dumbbell Bench Press", "Bench Press", "Cable Crossover", "Barbell Bench Press Medium Grip"],
        
        "Back": ["Reverse Grip Row", "Negative Pullup", "Burpee Pullup","Man Makers", "Lying T-Bar Row", "Bent Over Two Arm Long Bar Row", "Close Grip Front Lat Pulldown", "Bent Arm Dumbbell Pullover", "Rack Pulls", "Wide Grip Lat Pulldown", "Superman", "Straight Arm Pulldown", "Seated Cable Rows", "One Arm Dumbbell Row", "Bent Over Two Dumbbell Row", "Chin-Ups", "Pullups", "Bent Over Barbell Row"],
        
        "Shoulders": ["Waiter's Carry", "Dumbbell Clean & Jerk", "Wall Walks", "Hand Stand Pushups", "Dumbbell Shoulder Press", "Dumbbell Rotational Shoulder Press", "Dumbbell Shrug", "Upright Barbell Row", "Seated Barbell Military Press", "Barbell Shrug", "Barbell Shoulder Press", "Barbell Rear Delt Row", "Face Pull", "Standing Dumbbell Upright Row", "Side Lateral Raise", "Seated Bent Over Rear Delt Raise", "Push Press", "Arnold Dumbbell Press", "Reverse Flyes"],
        
        "Legs": ["Reverse Lunge", "Good Mornings", "Kettlebell Sumo Squat", "Wide Stance Barbell Squat", "Romanian Deadlift", "Barbell Thrusters", "Plate Push", "Stiff Leg Dumbbell Deadlift", "Barbell Back Squat", "Leg Extensions", "Lying Hamstring Curls", "Single-Leg Knee Tap Squat", "Split Squat", "Dumbbell Steps Ups", "Hang Clean", "Clean and Jerk", "Barbell Hip Thrust", "Standing Calf Raises", "Smith Machine Squat", "Lying Leg Curls", "Front Barbell Squat", "Glute Ham Raise", "Power Clean", "Leg Press", "Barbell Deadlift", "Lunges", "Hack Squat"],
        
        "Arms": ["Wrist Roller", "Behind the Back Wrist Curl", "Triceps Dumbbell Kickback", "Dumbbell Triceps Extension", "One Arm Dumbbell Preacher Curls", "EZ-Bar Curl", "Preacher Curl", "Barbell Curl", "Dumbbell Bicep Curl", "Hammer Curl", "Concentration Curls", "Dips", "Spider Curl", "Triceps Pushdown", "Cable Rope Overhead Tricep Extension", "Close Grip Bench Press"],
        
        "Abs": ["Wall Walks", "Waiter's Carry", "Ab Walk-Out", "Hanging Pike", "Standing Cable Wood Chop", "Sit Up", "Hanging Leg Raise", "Jackknife Sit Up", "Dumbbell Side Bend", "Barbell Side Bend", "Cable Crunch", "Ab Crunch Machine", "Reverse Crunch", "Air Bike", "Crunches", "Ab Roller", "Plank", "Russian Twist", "Stomach Vacuum", "Decline Reverse Crunch"]
    ]
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    var objectArray = [Objects]()
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for (key, value) in bodyParts {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        exercises.removeAll()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"build1"), style: .Plain, target: self, action: #selector(BuildCollectionViewController.buildTapped))
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 16)!]
        self.navigationItem.title = "Build"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectArray.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! BuildCollectionViewCell
        cell.buildCellLabel.text = objectArray[indexPath.row].sectionName
        cell.layer.cornerRadius = 8
        return cell
    }
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        selected = Int(indexPath.row)
        performSegueWithIdentifier("ExerciseSegue", sender: self)
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ExerciseSegue" {
            let upcoming:BuildTableViewController = segue.destinationViewController as! BuildTableViewController
            upcoming.naviTitle = objectArray[selected].sectionName
            upcoming.temp = objectArray[selected].sectionObjects
        }
    }
    func buildTapped() {
        if(exercises.count == 0) {
            let alert = UIAlertController(title: "Missing exercises to build!", message: .None, preferredStyle: .Alert)
            let OK = UIAlertAction(title: "OK", style: .Default, handler: { (action:UIAlertAction) in
            })
            alert.addAction(OK)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("saveSeg", sender: self)
        }
    }
}