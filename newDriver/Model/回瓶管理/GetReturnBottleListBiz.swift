//
//  GetReturnBottleListBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class GetReturnBottleListBiz: NSObject {
    
    /// 获取大瓶中瓶小瓶的信息
    var orders: [BottleOrder] = []
    
    /// 分页加载，正在加载的页数
    var tempPage: Int = 1
    
    /// 分页加载，已加载完的页数
    var page: Int = 1
    
    func GetReturnBottleList (TMS_DRIVER_IDX tmsIdx: String, strType type: String, strPageCount pageCount: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "BUSINESS_IDX": "",
            "ORD_ORG_IDX": "",
            "TMS_DRIVER_IDX": tmsIdx,
            "strType": type,
            "strPage": "\(tempPage)",
            "strPageCount": pageCount,
            "strEndDate": "",
            "strStartDate": "",
            "strLicense": ""
        ]
        print(parameters)
        
        weak var weakSelf = self
        Alamofire.request(URLConstants.kAPI_GetReturnBottleList, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        if let wkSelf = weakSelf {
                            let type = json["type"].description
                            if type == "1" {
                                
                                if wkSelf.tempPage == 1 {
                                    wkSelf.orders.removeAll()
                                }
                                
                                let list: Array<JSON> = json["result"]["List"].arrayValue
                                if(list.count == 0) {
                                    responseProtocol.responseSuccess_noData!()
                                } else {
                                    for json in list {
                                        let order: BottleOrder = Mapper<BottleOrder>().map(JSONString: json.description)!
                                        let oneLine = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
                                        //                                    let mulLine = Tools.getHeightOfString(text: order.PARTY_NAME, fontSize: 15, width: (SCREEN_WIDTH - (15 + 46 + 3)))
                                        order.cellHeight = 82
                                        wkSelf.orders.append(order)
                                    }
                                    wkSelf.page = self.tempPage
                                    responseProtocol.responseSuccess()
                                }
                            } else {
                                let msg = json["msg"].description
                                responseProtocol.responseError(msg)
                            }
                        }
                    }
                case .failure(let error):
                    responseProtocol.responseError("提交订单失败！")
                    print(error)
                }
        }
    }
}
