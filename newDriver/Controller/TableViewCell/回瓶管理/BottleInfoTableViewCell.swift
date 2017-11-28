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
    @IBOutlet public weak var qtyF: UITextField!
    @IBOutlet weak var lineView: UIView!
    var ORD_WORKFLOW: String = ""
    
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
            
            if(ORD_WORKFLOW == "新建" || ORD_WORKFLOW == "已审核" || ORD_WORKFLOW == "已释放" || ORD_WORKFLOW == "已装运" || ORD_WORKFLOW == "已确认") {
                
            } else {
                lineView.isHidden = true
                qtyF.text = bottle.ISSUE_QTY
                qtyF.isEnabled = false
            }
        }
    }
    
    @IBAction func changeOnclick(_ sender: UITextField) {
        bottle.ISSUE_QTY = sender.text!
    }
}
