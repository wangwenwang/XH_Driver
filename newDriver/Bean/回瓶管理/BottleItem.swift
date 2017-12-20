//
//  BottleItem.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import ObjectMapper

class BottleItem: BaseBean {
    
    /// ID号
    var IDX: String = ""
    
    /// 企业IDX
    var ENT_IDX: String = ""
    
    /// 订单头ID号
    var ORDER_IDX: String = ""
    
    /// 产品代码
    var PRODUCT_NO: String = ""
    
    /// 产品名称
    var PRODUCT_NAME: String = ""
    
    /// 产品说明
    var PRODUCT_DESC: String = ""
    
    /// 产品条码
    var PRODUCT_BARCODE: String = ""
    
    /// PO数量
    var PO_QTY: String = ""
    
    /// 订单数量
    var ORDER_QTY: String = ""
    
    /// 实运数量(司机确认过)
    var ISSUE_QTY: String = ""
    
    /// 实收数量(工厂确认过)
    var QTY_DELIVERY: String = ""
    
    /// 不合格数量(工厂确认过)
    var QTY_REJECT: String = ""
    
    /// 短少数量(实运 - 实收 - 不合格)
    var QTY_MISSING: String = ""
    
    /// Cell 行高
    var cellHeight: CGFloat = 0
    
    override func mapping(map: Map) {
        IDX <- map["IDX"]
        ENT_IDX <- map["ENT_IDX"]
        ORDER_IDX <- map["ORDER_IDX"]
        PRODUCT_NO <- map["PRODUCT_NO"]
        PRODUCT_NAME <- map["PRODUCT_NAME"]
        PRODUCT_DESC <- map["PRODUCT_DESC"]
        PRODUCT_BARCODE <- map["PRODUCT_BARCODE"]
        PO_QTY <- map["PO_QTY"]
        ORDER_QTY <- map["ORDER_QTY"]
        ISSUE_QTY <- map["ISSUE_QTY"]
        QTY_DELIVERY <- map["QTY_DELIVERY"]
        QTY_REJECT <- map["QTY_REJECT"]
        QTY_MISSING <- map["QTY_MISSING"]
    }
}
