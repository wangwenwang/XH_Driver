//
//  Carrier.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import ObjectMapper

class Carrier: BaseBean {
    /// 车队ID
    var TMS_FLEET_IDX: String = ""
    
    /// 承运商
    var TMS_FLEET_NAME: String = ""
    
    /// 车辆ID
    var TMS_VEHICLE_IDX: String = ""
    
    /// 车牌号
    var TMS_PLATE_NUMBER: String = ""
    
    /// 车辆类型
    var TMS_VEHICLE_TYPE: String = ""
    
    /// 车辆尺寸
    var TMS_VEHICLE_SIZE: String = ""
    
    /// 司机ID
    var TMS_DRIVER_IDX: String = ""
    
    /// 司机姓名
    var TMS_DRIVER_NAME: String = ""
    
    /// 司机联系电话
    var TMS_DRIVER_TEL: String = ""
    
    /// 业务id
    var ord_org_idx: String = ""
    
    /// 业务名称
    var org_desc: String = ""
    
    /// Cell 行高
    var cellHeight: CGFloat = 0
    
    override func mapping(map: Map) {
        TMS_FLEET_IDX <- map["TMS_FLEET_IDX"]
        TMS_FLEET_NAME <- map["TMS_FLEET_NAME"]
        TMS_VEHICLE_IDX <- map["TMS_VEHICLE_IDX"]
        TMS_PLATE_NUMBER <- map["TMS_PLATE_NUMBER"]
        TMS_VEHICLE_TYPE <- map["TMS_VEHICLE_TYPE"]
        TMS_VEHICLE_SIZE <- map["TMS_VEHICLE_SIZE"]
        TMS_DRIVER_IDX <- map["TMS_DRIVER_IDX"]
        TMS_DRIVER_NAME <- map["TMS_DRIVER_NAME"]
        TMS_DRIVER_TEL <- map["TMS_DRIVER_TEL"]
        ord_org_idx <- map["ord_org_idx"]
        org_desc <- map["org_desc"]
    }
}
