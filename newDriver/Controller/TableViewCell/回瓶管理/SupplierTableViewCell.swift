//
//  SupplierTableViewCell.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/20.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class SupplierTableViewCell: UITableViewCell {

    /// 供应商名称
    @IBOutlet weak var PARTY_NAME: UILabel!
    
    /// 供应商地址
    @IBOutlet weak var PARTY_ADDRESS: UILabel!
    
    var address: BottleAddressList! {
        didSet {
            upDataUi()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func upDataUi() {
        PARTY_NAME.text = address.PARTY_NAME
        PARTY_ADDRESS.text = address.PARTY_PROVINCE + address.PARTY_CITY
    }
}
