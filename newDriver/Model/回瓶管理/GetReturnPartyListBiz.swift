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
import ObjectMapper

class GetReturnPartyListBiz: NSObject {
    
    /// 厂商/经销商地址
    var addressList: [BottleAddressList] = []
    
    func GetReturnPartyList (strUserId userid: String, strBusinessId bussinessid: String, strType type: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "strUserId": userid,
            "strBusinessId": bussinessid,
            "strType": type,
            "strLicense": ""
        ]
        print(parameters)
        
        weak var weakSelf = self
        Alamofire.request(URLConstants.kAPI_GetReturnPartyList, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let xxx):
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        if let wkSelf = weakSelf {
                            let type = json["type"].description
                            if type == "1" {
                                
                                let list: Array<JSON> = json["result"].arrayValue
                                for json in list {
                                    let address: BottleAddressList = Mapper<BottleAddressList>().map(JSONString: json.description)!
                                    let oneLine = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
                                    let mulLine = Tools.getHeightOfString(text: address.PARTY_NAME, fontSize: 15, width: (SCREEN_WIDTH - (15 + 46 + 3)))
                                    address.cellHeight = 59 + (mulLine - oneLine)
                                    wkSelf.addressList.append(address)
                                }
                                responseProtocol.responseSuccess()
                            } else {
                                let msg = json["msg"].description
                                responseProtocol.responseError(msg)
                            }
                        }
                    }
                case .failure(let error):
                    responseProtocol.responseError("请求厂商信息失败！")
                    print(error)
                }
        }
    }
}
