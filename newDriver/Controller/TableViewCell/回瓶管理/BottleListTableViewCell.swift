//
//  BottleListTableViewCell.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleListTableViewCell: UITableViewCell {

    @IBOutlet weak var ORD_NO: UILabel!
    @IBOutlet weak var ORD_TO_ADDRESS: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var order: BottleOrder! {
        didSet {
            ORD_NO.text = order.ORD_NO
            ORD_TO_ADDRESS.text = order.ORD_TO_ADDRESS
        }
    }
}
