//
//  WorkoutObject.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/2/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//
import UIKit
import RealmSwift
class Exercise: Object {
    dynamic var Name : String = ""
    dynamic var reps : String = ""
    dynamic var sets : String = ""
    dynamic var max : String = "--"
}
class WorkoutItem: Object {
    dynamic var Name : String = ""
    dynamic var date : String = ""
    let workoutList = List<Exercise>()
}