//
//  BottleInfoTableViewCell.swift
//  newDriver
//
//  Created by wenwang wang on 2017/11/27.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleInfoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var bottle: BottleItem! {
        didSet {
//            ORD_NO.text = bottle.ORD_NO
//            ORD_DATE_ADD.text = bottle.ORD_DATE_ADD
//            ORD_TO_ADDRESS.text = bottle.ORD_TO_ADDRESS
//            ORD_WORKFLOW.text = bottle.ORD_WORKFLOW
        }
    }
}
