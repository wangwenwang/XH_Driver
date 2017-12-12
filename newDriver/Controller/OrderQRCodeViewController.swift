//
//  OrderQRCodeViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class OrderQRCodeViewController: UIViewController {
    
    @IBOutlet private weak var myQRCode: UIImageView!
    
    /// 装运号
    var TMS_SHIPMENT_NO: String!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "装运二维码"
        
        myQRCode.image = TMS_SHIPMENT_NO.generateQRCodeWithLogo(logo: UIImage(named: "icon_60"))
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
