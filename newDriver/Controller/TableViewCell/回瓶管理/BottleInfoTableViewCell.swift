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
    @IBOutlet weak var QTY_DELIVERY: UILabel!
    @IBOutlet weak var QTY_MISSING: UILabel!
    @IBOutlet weak var QTY_REJECT: UILabel!
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
            QTY_DELIVERY.text = bottle.QTY_DELIVERY
            QTY_MISSING.text = bottle.QTY_MISSING
            QTY_REJECT.text = bottle.QTY_REJECT
            
            if(ORD_WORKFLOW == "新建" || ORD_WORKFLOW == "已审核" || ORD_WORKFLOW == "已释放" || ORD_WORKFLOW == "已装运" || ORD_WORKFLOW == "已确认") {
                
                qtyF.isEnabled = true
                lineView.isHidden = false
                bottle.ISSUE_QTY = bottle.ORDER_QTY
            } else {
                
                qtyF.isEnabled = false
                lineView.isHidden = true
            }
            qtyF.text = bottle.ISSUE_QTY
        }
    }
    
    @IBAction func changeOnclick(_ sender: UITextField) {
        bottle.ISSUE_QTY = sender.text!
    }
}
