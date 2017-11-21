//
//  ImportToOrderListBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class ImportToOrderListBiz: NSObject {
    
    func GetShipmentList (strOrderInfo str: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "strOrderInfo": str,
            "strLicense": ""
        ]
        print(parameters)
        
        Alamofire.request(URLConstants.kAPI_GetShipmentList, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        let type = json["type"].description
                        if type == "1" {
                            responseProtocol.responseSuccess()
                        } else {
                            let msg = json["msg"].description
                            responseProtocol.responseError(msg)
                        }
                    }
                case .failure(let error):
                    responseProtocol.responseError("提交订单失败！")
                    print(error)
                }
        }
    }
}
