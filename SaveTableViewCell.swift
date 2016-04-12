//
//  SaveTableViewCell.swift
//  NoleFit
//
//  Created by Lazaro Romero on 4/1/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
class SaveTableViewCell: UITableViewCell {
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet var cellButton: UIButton!
   
    var onButtonTouched : (() -> Void)? = nil

    @IBAction func cellButtonTouched(sender: AnyObject) {
        if let onButtonTouched = self.onButtonTouched {
            onButtonTouched()
        }
    }
}