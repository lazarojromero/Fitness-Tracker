//
//  BuildTableViewCell.swift
//  NoleFit
//
//  Created by Lazaro Romero on 3/31/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
class BuildTableViewCell: UITableViewCell {
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    
    var onButtonTouched : (() -> Void)? = nil
    
    @IBAction func cellButtonTouched(sender: AnyObject) {
        if let onButtonTouched = self.onButtonTouched {
            onButtonTouched()
        }
    }
}
