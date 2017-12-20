//
//  SHIPMENT_List.swift
//  newDriver
//
//  Created by 凯东源 on 16/12/15.
//  Copyright © 2016年 凯东源. All rights reserved.
//

import Foundation
import ObjectMapper

class SHIPMENT_List: BaseBean {
    
    /// 订单号
    var ORD_NO: String = ""
    
    /// 订单ID
    var ORD_IDX: String = ""
    
    /// 客户订单号
    var ORD_NO_CLIENT: String = ""
    
    /// 到达点名称
    var ORD_TO_NAME: String = ""
    
    /// 订单类型
    var ORD_TYPE: String = ""
    
    /// 搬运类型
    var ORD_TYPE_HANDLING: String = ""
    
    override func mapping(map: Map) {
        ORD_NO <- map["ORD_NO"]
        ORD_IDX <- map["ORD_IDX"]
        ORD_NO_CLIENT <- map["ORD_NO_CLIENT"]
        ORD_TO_NAME <- map["ORD_TO_NAME"]
        ORD_TYPE <- map["ORD_TYPE"]
        ORD_TYPE_HANDLING <- map["ORD_TYPE_HANDLING"]
    }
}
