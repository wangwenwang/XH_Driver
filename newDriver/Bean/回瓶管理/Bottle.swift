//
//  Bottle.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import ObjectMapper

class Bottle: BaseBean {
    /// Idx
    var IDX: String = ""
    
    /// 产品号
    var PRODUCT_NO: String = ""
    
    /// 名称
    var PRODUCT_NAME: String = ""
    
    /// 说明
    var PRODUCT_DESC: String = ""
    
    /// 条码
    var PRODUCT_BARCODE: String = ""
    
    /// 状态
    var PRODUCT_STATE: String = ""
    
    override func mapping(map: Map) {
        IDX <- map["IDX"]
        PRODUCT_NO <- map["PRODUCT_NO"]
        PRODUCT_NAME <- map["PRODUCT_NAME"]
        PRODUCT_DESC <- map["PRODUCT_DESC"]
        PRODUCT_BARCODE <- map["PRODUCT_BARCODE"]
        PRODUCT_STATE <- map["PRODUCT_STATE"]
    }
}
