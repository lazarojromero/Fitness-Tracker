//
//  WorkoutTableViewCell.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/2/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import RealmSwift
class WorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var exLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
