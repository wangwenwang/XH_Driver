//
//  NewToFoctoryBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class NewToFoctoryBiz: NSObject {
    
    /// 订单详情信息
    var msg: String?
    
    /// 记录到厂时间
    func ToFoctory (andstridx stridx: String, andDriverIdx DriverIdx: String, andFromCode FromCode: String,  andAPI API: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "stridx": stridx,
            "DriverIdx": DriverIdx,
            "FromCode": FromCode,
            "strLicense": ""
        ]
        print(parameters)
        
        Alamofire.request(API, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        let type = json["type"].description
                        let msg = json["msg"].description
                        self.msg = msg
                        if type == "1" {
                            
                            responseProtocol.responseSuccess()
                        } else {
                            responseProtocol.responseError(msg)
                        }
                    }
                case .failure(let error):
                    responseProtocol.responseError("请求记录到厂时间失败！")
                    print(error)
                }
        }
    }
}
