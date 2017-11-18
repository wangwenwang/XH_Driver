//
//  GetReturnPartyListBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GetReturnPartyListBiz: NSObject {

    func payOrderWithPicture (orderIdx idx: String, autographStr str: String, image1Str str1: String, image2Str str2: String, deliveNoStr str3 : String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "strOrdersIdx": idx,
            "AutographFile": str,
            "PictureFile1": str1,
            "PictureFile2": str2,
            "strDeliveNo" : str3,
            "strLicense": ""
        ]
        
        print(parameters)
        
        Alamofire.request(URLConstants.kAPI_DriverListPay, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    print(xxx)
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
