//
//  GetReturnBottleInfoBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class GetReturnBottleInfoBiz: NSObject {
    
    /// 获取瓶子详情
    var bottleDetail: BottleDetail?
    
    func GetReturnBottleInfo (ORDER_IDX idx: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "ORDER_IDX": idx,
            "strLicense": ""
        ]
        print(parameters)
        
        weak var weakSelf = self
        
        print(parameters)
        Alamofire.request(URLConstants.kAPI_GetReturnBottleInfo, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
//                        if let wkSelf = weakSelf {
                            let type = json["type"].description
                            if type == "1" {
                                
                                let detail: BottleDetail = Mapper<BottleDetail>().map(JSONString: json["result"].description)!
                                
//                                let orderDetailArray = json["result"]["List"].arrayValue
//                                detail.List = []
//                                for bottle in orderDetailArray {
//                                    detail.List.append(Mapper<BottleItem>().map(JSONString: bottle.description)!)
//                                }
                                
                                
                                //                                    let oneLine = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
                                //                                    let mulLine = Tools.getHeightOfString(text: address.PARTY_NAME, fontSize: 15, width: (SCREEN_WIDTH - (15 + 46 + 3)))
                                //                                    address.cellHeight = 59 + (mulLine - oneLine)
                                self.bottleDetail = detail
                                responseProtocol.responseSuccess()
//                            } else {
//                                let msg = json["msg"].description
//                                responseProtocol.responseError(msg)
//                            }
                        }
                    }
                case .failure(let error):
                    responseProtocol.responseError("提交订单失败！")
                    print(error)
                }
        }
    }
}
