//
//  BottleInfoViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleInfoViewController: UIViewController, HttpResponseProtocol {
    
    func responseSuccess() {
        
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        customer_NAME.text = " "
        customer_ADDRESS.text = biz.bottleDetail.Info?.ORD_FROM_ADDRESS
        customer_PERSON.text = biz.bottleDetail.Info?.ORD_FROM_CNAME
        customer_TEL.text = biz.bottleDetail.Info?.ORD_FROM_CTEL
        let oneLine: CGFloat = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
        let mulLine: CGFloat = Tools.getHeightOfString(text: (biz.bottleDetail.Info?.ORD_FROM_ADDRESS)!, fontSize: 15, width: SCREEN_WIDTH - 8 - 46 + 2 - 3)
        customerViewHeight.constant += (mulLine - oneLine)
        
        
        PARTY_NAME.text = " "
        PARTY_ADDRESS.text = biz.bottleDetail.Info?.ORD_TO_ADDRESS
        
        for b in biz.bottleDetail.List {
            if(b.PRODUCT_NAME == "小瓶") {
                littleLabel.text = Tools.oneDecimal(text: b.ISSUE_QTY)
            } else if(b.PRODUCT_NAME == "中瓶") {
                midLabel.text = Tools.oneDecimal(text: b.ISSUE_QTY)
            } else if(b.PRODUCT_NAME == "大瓶") {
                maxLabel.text = Tools.oneDecimal(text: b.ISSUE_QTY)
            } else if(b.PRODUCT_NAME == "托盘") {
                trayLabel.text = Tools.oneDecimal(text: b.ISSUE_QTY)
            }
        }
        totalLabel.text = Tools.oneDecimal(text: biz.bottleDetail.Info!.ORD_ISSUE_QTY)
    }
    
    func responseError(_ error: String) {
        
         _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    
    public var ORDER_IDX: String!
    
    let biz: GetReturnBottleInfoBiz = GetReturnBottleInfoBiz()
    
    // 客户名称
    @IBOutlet weak var customer_NAME: UILabel!
    // 客户地址
    @IBOutlet weak var customer_ADDRESS: UILabel!
    // 客户联系人
    @IBOutlet weak var customer_PERSON: UILabel!
    // 客户电话
    @IBOutlet weak var customer_TEL: UILabel!
    @IBOutlet weak var customerViewHeight: NSLayoutConstraint!
    var customerViewHeight_static: CGFloat = 0
    
    // 供应商名称
    @IBOutlet weak var PARTY_NAME: UILabel!
    // 供应商地址
    @IBOutlet weak var PARTY_ADDRESS: UILabel!
    
    
    @IBOutlet weak var littleLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var trayLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var littleF: UITextField!
    @IBOutlet weak var midF: UITextField!
    @IBOutlet weak var maxF: UITextField!
    @IBOutlet weak var trayF: UITextField!
    
    // 车牌号
    @IBOutlet weak var TMS_PLATE_NUMBER: UILabel!
    // 车辆类型
    @IBOutlet weak var TMS_VEHICLE_TYPE: UILabel!
    // 司机姓名
    @IBOutlet weak var TMS_DRIVER_NAME: UILabel!
    // 司机联系电话
    @IBOutlet weak var TMS_DRIVER_TEL: UILabel!
    // 承运商
    @IBOutlet weak var TMS_FLEET_NAME: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "订单详情"
        
        initUI()
        
        _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        biz.GetReturnBottleInfo(ORDER_IDX: ORDER_IDX, httpresponseProtocol: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 函数
    func initUI() {
        customer_NAME.text = " "
        customer_ADDRESS.text = " "
        customer_PERSON.text = " "
        customer_TEL.text = " "
        
        PARTY_NAME.text = " "
        PARTY_ADDRESS.text = " "
        
        littleLabel.text = " "
        midLabel.text = " "
        maxLabel.text = " "
        trayLabel.text = " "
        totalLabel.text = " "
        
        TMS_PLATE_NUMBER.text = " "
        TMS_VEHICLE_TYPE.text = " "
        TMS_DRIVER_NAME.text = " "
        TMS_DRIVER_TEL.text = " "
        TMS_FLEET_NAME.text = " "
    }
    
    // MARK: - 事件
    @IBAction func modify() {
        let vc: ModifyBottleViewController = ModifyBottleViewController(nibName: "ModifyBottleViewController", bundle: nil)
        vc.strIdx = biz.bottleDetail.Info?.IDX
        vc.list = biz.bottleDetail.List
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmOnclick() {
        
        let little: Float = Float(littleF.text!)!
        let mid: Float = Float(midF.text!)!
        let max: Float = Float(maxF.text!)!
        let tray: Float = Float(trayF.text!)!
        
        for b in biz.bottleDetail.List {
            var qty: String!
            if(b.PRODUCT_NAME == "小瓶") {
                qty = littleF.text!
            } else if(b.PRODUCT_NAME == "中瓶") {
                qty = midF.text!
            } else if(b.PRODUCT_NAME == "大瓶") {
                qty = maxF.text!
            } else if(b.PRODUCT_NAME == "托盘") {
                qty = trayF.text!
            }
            let biz: SetBottleQTYBiz = SetBottleQTYBiz()
            biz.SetBottleQTY(strIdx: b.IDX, StrQty: qty, httpresponseProtocol: self)
        }
    }
}
