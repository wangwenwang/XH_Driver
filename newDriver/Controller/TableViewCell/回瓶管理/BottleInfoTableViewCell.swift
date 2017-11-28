//
//  BottleInfoTableViewCell.swift
//  newDriver
//
//  Created by wenwang wang on 2017/11/27.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var PRODUCT_NAME: UILabel!
    @IBOutlet weak var ORDER_QTY: UILabel!
    
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
            PRODUCT_NAME.text = bottle.PRODUCT_NAME
            ORDER_QTY.text = bottle.ORDER_QTY
        }
    }
    
    @IBAction func changeOnclick(_ sender: UITextField) {
        bottle.ISSUE_QTY = sender.text!
    }
}
