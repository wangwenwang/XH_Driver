//
//  SetBottleQTYBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class SetBottleQTYBiz: NSObject {
    
    func SetBottleQTY (strIdx idx: String, StrQty qty: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "strIdx": idx,
            "StrQty": qty,
            "strLicense": ""
        ]
        print(parameters)
        
        Alamofire.request(URLConstants.kAPI_SetBottleQTY, method: .post, parameters: parameters, encoding: URLEncoding.default)
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
                    responseProtocol.responseError("请求确认数量失败！")
                    print(error)
                }
        }
    }
}
