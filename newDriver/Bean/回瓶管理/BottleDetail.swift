//
//  BottleDetail.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import ObjectMapper

class BottleDetail: BaseBean {

    /// 详情
    var Info: BottleInfo?
    
    /// 瓶子列表
    var List: [BottleItem] = []
    
    override func mapping(map: Map) {
        Info <- map["Info"]
        List <- map["List"]
    }
}
