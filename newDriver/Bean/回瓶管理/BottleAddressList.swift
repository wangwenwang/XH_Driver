//
//  BottleAddressList.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/20.
//  Copyright © 2017年 凯东源. All rights reserved.
//


import Foundation
import ObjectMapper

class BottleAddressList: BaseBean {
    /// id
    var IDX: String = ""
    
    /// 代码
    var PARTY_CODE: String = ""
    
    /// 名称
    var PARTY_NAME: String = ""
    
    /// 属性
    var PARTY_PROPERTY: String = ""
    
    /// 分类
    var PARTY_CLASS: String = ""
    
    /// 类型
    var PARTY_TYPE: String = ""
    
    /// 国家
    var PARTY_COUNTRY: String = ""
    
    /// 省会
    var PARTY_PROVINCE: String = ""
    
    /// 城市
    var PARTY_CITY: String = ""
    
    /// 备注
    var PARTY_REMARK: String = ""
    
    /// 业务代码
    var BUSINESS_IDX: String = ""
    
    /// Cell 行高
    var cellHeight: CGFloat = 0
    
    override func mapping(map: Map) {
        IDX <- map["IDX"]
        PARTY_CODE <- map["PARTY_CODE"]
        PARTY_NAME <- map["PARTY_NAME"]
        PARTY_PROPERTY <- map["PARTY_PROPERTY"]
        PARTY_CLASS <- map["PARTY_CLASS"]
        PARTY_TYPE <- map["PARTY_TYPE"]
        PARTY_COUNTRY <- map["PARTY_COUNTRY"]
        PARTY_PROVINCE <- map["PARTY_PROVINCE"]
        PARTY_CITY <- map["PARTY_CITY"]
        PARTY_REMARK <- map["PARTY_REMARK"]
        BUSINESS_IDX <- map["BUSINESS_IDX"]
    }
}
