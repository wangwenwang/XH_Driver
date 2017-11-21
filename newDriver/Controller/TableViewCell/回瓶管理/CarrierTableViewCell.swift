//
//  CarrierTableViewCell.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class CarrierTableViewCell: UITableViewCell {
    
    // 车牌号
    @IBOutlet weak var TMS_PLATE_NUMBER: UILabel!
    
    // 承运商
    @IBOutlet weak var TMS_FLEET_NAME: UILabel!
    
    // 司机姓名
    @IBOutlet weak var TMS_DRIVER_NAME: UILabel!
    
    // 司机联系电话
    @IBOutlet weak var TMS_DRIVER_TEL: UILabel!
    
    var carrier: Carrier! {
        didSet {
            upDataUi()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func upDataUi() {
        TMS_PLATE_NUMBER.text = carrier.TMS_PLATE_NUMBER
        TMS_FLEET_NAME.text = carrier.TMS_FLEET_NAME
        TMS_DRIVER_NAME.text = carrier.TMS_DRIVER_NAME
        TMS_DRIVER_TEL.text = carrier.TMS_DRIVER_TEL
    }
}
