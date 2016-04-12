//
//  GenerateCollectionVC.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/1/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class GenerateCollectionVC: UICollectionViewController {
    let photo = ["newChest", "newBack", "newShoulders","newArms", "newLegs", "newAbs"]
    let chestArr = ["Hand Release PushUps", "Cable Fly", "Incline Dumbbell Press", "Dips", "Decline Dumbbell Bench Press", "Close Grip Bench Press", "Butterfly", "Bent Arm Dumbbell Pullover", "Barbell Incline Bench", "Pushups", "Dumbbell Flyes", "Dumbbell Bench Press", "Bench Press", "Cable Crossover", "Barbell Bench Press Medium Grip"]
    let backArr = ["Reverse Grip Row", "Negative Pullup", "Burpee Pullup", "Straight Arm Pulldowns", "Man Makers", "Lying T-Bar Row", "Bent Over Two Arm Long Bar Row", "Close Grip Front Lat Pulldown", "Bent Arm Dumbbell Pullover", "Rack Pulls", "Wide Grip Lat Pulldown", "Superman", "Straight Arm Pulldown", "Seated Cable Rows", "One Arm Dumbbell Row", "Bent Over Two Dumbbell Row", "Chin-Ups", "Pullups", "Bent Over Barbell Row"]
    let absArr = ["Wall Walks", "Waiter's Carry", "Ab Walk-Out", "Hanging Pike", "Standing Cable Wood Chop", "Sit Up", "Hangling Leg Raise", "Jackknife Sit Up", "Dumbbell Side Bend", "Barbell Side Bend", "Cable Crunch", "Ab Crunch Machine", "Reverse Crunch", "Air Bike", "Crunches", "Ab Roller", "Plank", "Russian Twist", "Stomach Vacuum", "Decline Reverse Crunch"]
    let legsArr = ["Reverse Lunge", "Good Mornings", "Kettlebell Sumo Squat", "Wide Stance Barbell Squat", "Romanian Deadlift", "Barbell Thrusters", "Plate Push", "Stiff Leg Dumbbell Deadlift", "Barbell Back Squat", "Leg Extensions", "Lying Hamstring Curls", "Single-Leg Knee Tap Squat", "Split Squat", "Dumbbell Steps Ups", "Hang Clean", "Clean and Jerk", "Barbell Hip Thrust", "Standing Calf Raises", "Smith Machine Squat", "Lying Leg Curls", "Front Barbell Squat", "Lying Leg Curls", "Glute Ham Raise", "Power Clean", "Leg Press", "Barbell Deadlift", "Lunges", "Hack Squat"]
    let shoulderArr = ["Waiter's Carry", "Dumbbell Clean/Jerk", "Wall Walks", "Hand Stand Pushups", "Dumbbell Shoulder Press", "Dumbbell Rotational Shoulder Press", "Dumbbell Shrug", "Uright Barbell Row", "Seated Barbell Military Press", "Barbell Shrug", "Barbell Shoulder Press", "Barbell Read Delt Row", "Face Pull", "Standing Dumbbell Upright Row", "Side Lateral Raise", "Seated Bent Over Rear Delt Raise", "Push Press", "Arnold Dumbbell Press", "Reverse Flyes"]
    let armsArr = ["Wrist Roller", "Behind the Back Wrist Curl", "Triceps Dumbbell Kickback", "Dumbbell Triceps Extension", "One Arm Dumbbell Preacher Curls", "EZ-Bar Curl", "Preacher Curl", "Barbell Curl", "Dumbbell Bicep Curl", "Hammer Curl", "Concentration Curls", "Dips", "Spider Curl", "Triceps Pushdown", "Cable Rope Overhead Tricep Extension", "Close Grip Bench Press"]
    let parts = ["Chest", "Back","Shoulders", "Arms", "Legs", "Abs"]
    var selected = [String]()
    var randomArray = [String]()
    struct Model {
        var imageName : String
        var fade : Bool
    }
    var model = [Model]()
    var chestSelector = 0//not selected
    var backSelector = 0
    var shouldersSelector = 0
    var armsSelector = 0
    var absSelector = 0
    var legsSelector = 0
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for names in photo {
            model.append(Model(imageName: names, fade: false))
        }
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 16)!]
        self.navigationItem.title = "Generate"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"randomicon-1"), style: .Plain, target: self, action: #selector(GenerateCollectionVC.generateTapped))
    }
    override func viewWillAppear(animated: Bool) {
        randomArray.removeAll()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colCell", forIndexPath: indexPath) as! GenCollectionViewCell
        let mod = self.model[indexPath.item]
        cell.imageView.image = UIImage(named:mod.imageName)
        cell.imageView.layer.cornerRadius = 8
        cell.imageView.alpha = mod.fade ? 0.5 : 1.0
        cell.cellTitle.text = parts[indexPath.row]
        return cell
    }
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        model[indexPath.item].fade = true
        switch(indexPath.item) {
        case 0:
            if chestSelector == 0 {
                chestSelector = 1
                selected.append("Chest")
            } else if chestSelector == 1 {
                chestSelector = 0
                let index = selected.indexOf("Chest")
                selected.removeAtIndex(index!)
                model[indexPath.item].fade = false
            }; break
        case 1:
            if backSelector == 0 {
                backSelector = 1
                selected.append("Back")
            } else if backSelector == 1 {
                backSelector = 0
                let index = selected.indexOf("Back")
                selected.removeAtIndex(index!)
                model[indexPath.item].fade = false
            }; break
        case 2:
            if shouldersSelector == 0 {
                shouldersSelector = 1
                selected.append("Shoulders")
            } else if shouldersSelector == 1 {
                shouldersSelector = 0
                let index = selected.indexOf("Shoulders")
                selected.removeAtIndex(index!)
                model[indexPath.item].fade = false
            }; break
        case 3:
            if armsSelector == 0 {
                armsSelector = 1
                selected.append("Arms")
            } else if armsSelector == 1 {
                armsSelector = 0
                let index = selected.indexOf("Arms")
                selected.removeAtIndex(index!)
                model[indexPath.item].fade = false
            }; break
        case 4:
            if legsSelector == 0 {
                legsSelector = 1
                selected.append("Legs")
            } else if legsSelector == 1 {
                legsSelector = 0
                let index = selected.indexOf("Legs")
                selected.removeAtIndex(index!)
                model[indexPath.item].fade = false
            }; break
        case 5:
            if absSelector == 0 {
                absSelector = 1
                selected.append("Abs")
            } else if absSelector == 1 {
                absSelector = 0
                let index = selected.indexOf("Abs")
                selected.removeAtIndex(index!)
                model[indexPath.item].fade = false
            }; break
        default:
            break
        }
        collectionView.reloadData()
        return true
    }
    func generateTapped() {
        var limit = 0
        switch(selected.count) {
        case 0:
            let alert = UIAlertController(title: "Must choose a category to generate workout!", message: .None, preferredStyle: .Alert)
            let OK = UIAlertAction(title: "OK", style: .Default, handler: { (action:UIAlertAction) in
            })
            alert.addAction(OK)
            self.presentViewController(alert, animated: true, completion: nil)
            break
        case 1:
            limit = 8
            break
        case 2:
            limit = 5
            break
        case 3:
            limit = 4
            break
        case 4:
            limit = 3
            break
        case 5:
            limit = 2
            break
        case 6:
            limit = 2
            break
        default:
            break
        }
        if selected.count != 0 {
            for i in 0 ..< selected.count {
                if selected[i] == "Chest" {
                    var x = 0
                    while(x < limit) {
                        let randomIndex = Int(arc4random_uniform(UInt32(chestArr.count)))
                        if(randomArray.contains(chestArr[randomIndex])) {
                        } else {
                            randomArray.append(chestArr[randomIndex])
                            x = x + 1
                        }
                    }
                } else if selected[i] == "Back" {
                    var x = 0
                    while(x < limit) {
                        let randomIndex = Int(arc4random_uniform(UInt32(backArr.count)))
                        if(randomArray.contains(backArr[randomIndex])) {
                        } else {
                            randomArray.append(backArr[randomIndex])
                            x = x + 1
                        }
                    }
                } else if selected[i] == "Arms" {
                    var x = 0
                    while(x < limit) {
                        let randomIndex = Int(arc4random_uniform(UInt32(armsArr.count)))
                        if(randomArray.contains(armsArr[randomIndex])) {
                        } else {
                            randomArray.append(armsArr[randomIndex])
                            x = x + 1
                        }
                    }
                } else if selected[i] == "Shoulders" {
                    var x = 0
                    while(x < limit) {
                        let randomIndex = Int(arc4random_uniform(UInt32(shoulderArr.count)))
                        if(randomArray.contains(shoulderArr[randomIndex])) {
                        } else {
                            randomArray.append(shoulderArr[randomIndex])
                            x = x + 1
                        }
                    }
                } else if selected[i] == "Legs" {
                    var x = 0
                    while(x < limit) {
                        let randomIndex = Int(arc4random_uniform(UInt32(legsArr.count)))
                        if(randomArray.contains(legsArr[randomIndex])) {
                        } else {
                            randomArray.append(legsArr[randomIndex])
                            x = x + 1
                        }
                    }
                } else if selected[i] == "Abs" {
                    var x = 0
                    while(x < limit) {
                        let randomIndex = Int(arc4random_uniform(UInt32(absArr.count)))
                        if(randomArray.contains(absArr[randomIndex])) {
                        } else {
                            randomArray.append(absArr[randomIndex])
                            x = x + 1
                        }
                    }
                } else {
                    print("Unkown selected item.")
                }
            }
        }
        if randomArray.count != 0 {
            exercises = randomArray
            performSegueWithIdentifier("GenViewSegue", sender: self)
        }
    }
}
