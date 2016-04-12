//
//  EditViewController.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/2/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import RealmSwift
class EditViewController: UIViewController {
    @IBOutlet weak var saveTitleLbl: UILabel!
    let bodyParts:[String:[String]] = [
        "Chest": ["Hand Release PushUps", "Cable Fly", "Incline Dumbbell Press", "Dips", "Decline Dumbbell Bench Press", "Close Grip Bench Press", "Butterfly", "Bent Arm Dumbbell Pullover", "Barbell Incline Bench", "Pushups", "Dumbbell Flyes", "Dumbbell Bench Press", "Bench Press", "Cable Crossover", "Barbell Bench Press Medium Grip"],
        "Back": ["Reverse Grip Row", "Negative Pullup", "Burpee Pullup", "Straight Arm Pulldowns", "Man Makers", "Lying T-Bar Row", "Bent Over Two Arm Long Bar Row", "Close Grip Front Lat Pulldown", "Bent Arm Dumbbell Pullover", "Rack Pulls", "Wide Grip Lat Pulldown", "Superman", "Straight Arm Pulldown", "Seated Cable Rows", "One Arm Dumbbell Row", "Bent Over Two Dumbbell Row", "Chin-Ups", "Pullups", "Bent Over Barbell Row"],
        "Shoulders": ["Waiter's Carry", "Dumbbell Clean/Jerk", "Wall Walks", "Hand Stand Pushups", "Dumbbell Shoulder Press", "Dumbbell Rotational Shoulder Press", "Dumbbell Shrug", "Upright Barbell Row", "Seated Barbell Military Press", "Barbell Shrug", "Barbell Shoulder Press", "Barbell Read Delt Row", "Face Pull", "Standing Dumbbell Upright Row", "Side Lateral Raise", "Seated Bent Over Rear Delt Raise", "Push Press", "Arnold Dumbbell Press", "Reverse Flyes"],
        "Legs": ["Reverse Lunge", "Good Mornings", "Kettlebell Sumo Squat", "Wide Stance Barbell Squat", "Romanian Deadlift", "Barbell Thrusters", "Plate Push", "Stiff Leg Dumbbell Deadlift", "Barbell Back Squat", "Leg Extensions", "Lying Hamstring Curls", "Single-Leg Knee Tap Squat", "Split Squat", "Dumbbell Steps Ups", "Hang Clean", "Clean and Jerk", "Barbell Hip Thrust", "Standing Calf Raises", "Smith Machine Squat", "Lying Leg Curls", "Front Barbell Squat", "Lying Leg Curls", "Glute Ham Raise", "Power Clean", "Leg Press", "Barbell Deadlift", "Lunges", "Hack Squat"],
        "Arms": ["Wrist Roller", "Behind the Back Wrist Curl", "Triceps Dumbbell Kickback", "Dumbbell Triceps Extension", "One Arm Dumbbell Preacher Curls", "EZ-Bar Curl", "Preacher Curl", "Barbell Curl", "Dumbbell Bicep Curl", "Hammer Curl", "Concentration Curls", "Dips", "Spider Curl", "Triceps Pushdown", "Cable Rope Overhead Tricep Extension", "Close Grip Bench Press"],
        "Abs": ["Wall Walks", "Waiter's Carry", "Ab Walk-Out", "Hanging Pike", "Standing Cable Wood Chop", "Sit Up", "Hangling Leg Raise", "Jackknife Sit Up", "Dumbbell Side Bend", "Barbell Side Bend", "Cable Crunch", "Ab Crunch Machine", "Reverse Crunch", "Air Bike", "Crunches", "Ab Roller", "Plank", "Russian Twist", "Stomach Vacuum", "Decline Reverse Crunch"]
    ]
    var newSets = "Sets"
    var newReps = "Reps"
    var newMax = "Max (lbs)"
    var name = String()
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    var pickData: [[String]] = [["Sets"], ["Reps"], ["Max (lbs)"]]
    var ex = Exercise()
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        name = ex.Name
        saveTitleLbl.text = name
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"refresh"), style: .Plain, target: self, action: #selector(EditViewController.refreshTapped))
        for i in 1 ..< 51 {
            pickData[0].append("\(i)")
            pickData[1].append("\(i)")
        }
        for i in 1 ..< 200 {
            pickData[2].append("\(i*5)")
        }
        pickerView.backgroundColor = self.view.backgroundColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        if bodyParts["Abs"]!.contains(name) {
            imageView.image = UIImage(named:"absEdit")
        } else if bodyParts["Arms"]!.contains(name) {
            imageView.image = UIImage(named:"armsEdit")
        } else if bodyParts["Back"]!.contains(name) {
            imageView.image = UIImage(named:"backEdit")
        } else if bodyParts["Chest"]!.contains(name) {
            imageView.image = UIImage(named:"chestEdit")
        } else if bodyParts["Shoulders"]!.contains(name) {
            imageView.image = UIImage(named:"shouldersEdit")
        } else if bodyParts["Legs"]!.contains(name) {
            imageView.image = UIImage(named:"legsEdit")
        }
        reloadInputViews()
    }
    func refreshTapped() {
        if newSets != "Sets" {
            try! realm.write({
                ex.sets = newSets
            })
        }
        if newReps != "Reps" {
            try! realm.write({ 
                ex.reps = newReps
            })
        }
        if newMax != "Max (lbs)" {
            try! realm.write({ 
                ex.max = newMax
            })
        }
        navigationController?.popViewControllerAnimated(true)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickData[component].count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->String? {
        return pickData[component][row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component) {
        case 0:
            newSets = pickData[component][row]
        case 1:
            newReps = pickData[component][row]
        case 2:
            newMax = pickData[component][row]
        default:
            break;
        }
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickData[component][row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
}
