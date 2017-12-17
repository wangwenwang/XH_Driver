//
//  BottleInfo.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import ObjectMapper

class BottleInfo: BaseBean {
    
    /// idx
    var IDX: String = ""
    
    /// 订单组号
    var ORD_GROUP_NO: String = ""
    
    /// 订单号
    var ORD_NO: String = ""
    
    /// 客户订单号
    var ORD_NO_CLIENT: String = ""
    
    /// 状态
    var ORD_STATE: String = ""
    
    /// 流程
    var ORD_WORKFLOW: String = ""
    
    /// 起运点代码
    var ORD_FROM_CODE: String = ""
    
    /// 起运点名称
    var ORD_FROM_NAME: String = ""
    
    /// 起运点地址
    var ORD_FROM_ADDRESS: String = ""
    
    /// 起运点属性
    var ORD_FROM_PROPERTY: String = ""
    
    /// 起运点联系人
    var ORD_FROM_CNAME: String = ""
    
    /// 起运点联系电话
    var ORD_FROM_CTEL: String = ""
    
    /// 起运点短信号
    var ORD_FROM_CSMS: String = ""
    
    /// 起运点国家
    var ORD_FROM_COUNTRY: String = ""
    
    /// 起运点省份
    var ORD_FROM_PROVINCE: String = ""
    
    /// 起运点城市
    var ORD_FROM_CITY: String = ""
    
    /// 起运点区域
    var ORD_FROM_REGION: String = ""
    
    /// 起运点邮编
    var ORD_FROM_ZIP: String = ""
    
    /// 起运点标准地址
    var ORD_FROM_SITE: String = ""
    
    /// 到达点代码
    var ORD_TO_CODE: String = ""
    
    /// 到达点名称
    var ORD_TO_NAME: String = ""
    
    /// 到达点地址
    var ORD_TO_ADDRESS: String = ""
    
    /// 到达点属性
    var ORD_TO_PROPERTY: String = ""
    
    /// 到达点联系人
    var ORD_TO_CNAME: String = ""
    
    /// 到达点联系电话
    var ORD_TO_CTEL: String = ""
    
    /// 到达点短信号
    var ORD_TO_CSMS: String = ""
    
    /// 到达点国家
    var ORD_TO_COUNTRY: String = ""
    
    /// 到达点省份
    var ORD_TO_PROVINCE: String = ""
    
    /// 到达点城市
    var ORD_TO_CITY: String = ""
    
    /// 到达点区域
    var ORD_TO_REGION: String = ""
    
    /// 到达点邮编
    var ORD_TO_ZIP: String = ""
    
    /// 到达点标准地址
    var ORD_TO_SITE: String = ""
    
    /// 订单数量
    var ORD_QTY: String = ""
    
    /// 发货数量
    var ORD_ISSUE_QTY: String = ""
    
    /// 创建时间
    var ORD_DATE_ADD: String = ""
    
    /// 车牌号
    var TMS_PLATE_NUMBER: String = ""
    
    /// 车辆类型
    var TMS_VEHICLE_TYPE: String = ""
    
    /// 司机姓名
    var TMS_DRIVER_NAME: String = ""
    
    /// 司机联系电话
    var TMS_DRIVER_TEL: String = ""
    
    /// 承运商
    var TMS_FLEET_NAME: String = ""
    
    /// 装运号
    var TMS_SHIPMENT_NO: String = ""
    
    /// tableView 高度
    var tableViewHeight: CGFloat = 0
    
    override func mapping(map: Map) {
        IDX <- map["IDX"]
        ORD_GROUP_NO <- map["ORD_GROUP_NO"]
        ORD_NO <- map["ORD_NO"]
        ORD_NO_CLIENT <- map["ORD_NO_CLIENT"]
        ORD_STATE <- map["ORD_STATE"]
        ORD_WORKFLOW <- map["ORD_WORKFLOW"]
        ORD_FROM_CODE <- map["ORD_FROM_CODE"]
        ORD_FROM_NAME <- map["ORD_FROM_NAME"]
        ORD_FROM_ADDRESS <- map["ORD_FROM_ADDRESS"]
        ORD_FROM_PROPERTY <- map["ORD_FROM_PROPERTY"]
        ORD_FROM_CNAME <- map["ORD_FROM_CNAME"]
        ORD_FROM_CTEL <- map["ORD_FROM_CTEL"]
        ORD_FROM_CSMS <- map["ORD_FROM_CSMS"]
        ORD_FROM_COUNTRY <- map["ORD_FROM_COUNTRY"]
        ORD_FROM_PROVINCE <- map["ORD_FROM_PROVINCE"]
        ORD_FROM_CITY <- map["ORD_FROM_CITY"]
        ORD_FROM_REGION <- map["ORD_FROM_REGION"]
        ORD_FROM_ZIP <- map["ORD_FROM_ZIP"]
        ORD_FROM_SITE <- map["ORD_FROM_SITE"]
        ORD_TO_CODE <- map["ORD_TO_CODE"]
        ORD_TO_NAME <- map["ORD_TO_NAME"]
        ORD_TO_ADDRESS <- map["ORD_TO_ADDRESS"]
        ORD_TO_PROPERTY <- map["ORD_TO_PROPERTY"]
        ORD_TO_CNAME <- map["ORD_TO_CNAME"]
        ORD_TO_CTEL <- map["ORD_TO_CTEL"]
        ORD_TO_CSMS <- map["ORD_TO_CSMS"]
        ORD_TO_COUNTRY <- map["ORD_TO_COUNTRY"]
        ORD_TO_PROVINCE <- map["ORD_TO_PROVINCE"]
        ORD_TO_CITY <- map["ORD_TO_CITY"]
        ORD_TO_REGION <- map["ORD_TO_REGION"]
        ORD_TO_ZIP <- map["ORD_TO_ZIP"]
        ORD_TO_SITE <- map["ORD_TO_SITE"]
        ORD_QTY <- map["ORD_QTY"]
        ORD_ISSUE_QTY <- map["ORD_ISSUE_QTY"]
        ORD_DATE_ADD <- map["ORD_DATE_ADD"]
        TMS_PLATE_NUMBER <- map["TMS_PLATE_NUMBER"]
        TMS_VEHICLE_TYPE <- map["TMS_VEHICLE_TYPE"]
        TMS_DRIVER_NAME <- map["TMS_DRIVER_NAME"]
        TMS_DRIVER_TEL <- map["TMS_DRIVER_TEL"]
        TMS_FLEET_NAME <- map["TMS_FLEET_NAME"]
        TMS_SHIPMENT_NO <- map["TMS_SHIPMENT_NO"]
    }
}
