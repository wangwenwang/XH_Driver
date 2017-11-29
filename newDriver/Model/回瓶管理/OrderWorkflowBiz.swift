//
//  OrderWorkflowBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class OrderWorkflowBiz: NSObject {
    
    func OrderWorkflow (stridx idx: String, ADUT_USER user: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "stridx": idx,
            "ADUT_USER": user,
            "strLicense": ""
        ]
        print(parameters)
        
        Alamofire.request(URLConstants.kAPI_OrderWorkflow, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        let type = json["type"].description
                        if type == "1" {
                            responseProtocol.responseSuccess_audit!()
                        } else {
                            let msg = json["msg"].description
                            responseProtocol.responseError_audit!(msg)
                        }
                    }
                case .failure(let error):
                    responseProtocol.responseError_audit!("请求确认失败！")
                    print(error)
                }
        }
    }
}
