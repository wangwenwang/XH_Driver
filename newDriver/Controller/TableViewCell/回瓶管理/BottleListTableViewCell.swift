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
    @IBOutlet weak var ORD_DATE_ADD: UILabel!
    @IBOutlet weak var ORD_TO_ADDRESS: UILabel!
    @IBOutlet weak var ORD_WORKFLOW: UILabel!
    
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
            let work: String = order.ORD_WORKFLOW
            ORD_NO.text = order.ORD_NO
            ORD_DATE_ADD.text = order.ORD_DATE_ADD
            ORD_TO_ADDRESS.text = order.ORD_TO_ADDRESS
            ORD_WORKFLOW.text = work
            if(work == "已确认") {
                ORD_WORKFLOW.text = "待出库"
            } else if(
                work == "新建" ||
                work == "已释放" ||
                work == "已装运" ||
                work == "已审核") {
                ORD_WORKFLOW.text = "\(work)(异常)"
            }
        }
    }
}
