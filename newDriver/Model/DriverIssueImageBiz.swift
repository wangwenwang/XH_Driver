//
//  DriverIssueImageBiz.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/13.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import Alamofire

class DriverIssueImageBiz: NSObject {
    
    /**
     * 将 uiimage 对象转换成 base64 字符串
     *
     * image: 需要转换的图片
     *
     * return 转换完对应图片的 base64 字符串
     */
    func changeImageToString (_ image: UIImage?) -> String {
        if let im = image {
            let imageData = UIImagePNGRepresentation(im)
            if let data = imageData {
                return data.base64EncodedString(options: .lineLength64Characters)
            }
        }
        return ""
    }

    /**
     * 提交订单
     *
     * strOrdersIdx: 订单的 idx数组
     *
     * autographStr: 签名图片的 base64 字符串
     *
     * image1Str: 现场图片1的 base64 字符串
     *
     * image2Str: 现场图片2的 base64 字符串
     *
     * httpresponseProtocol: 网络请求协议
     */
    func DriverIssueImage (shipment_no no: String, struseridx useridx: String, PictureFile1 str1: String, PictureFile2 str2: String, httpresponseProtocol responseProtocol: HttpResponseProtocol) {
        
        let parameters = [
            "shipment_no": no,
            "struseridx": useridx,
            "PictureFile1": str1,
            "PictureFile2": str2,
            "strLicense": ""
        ]
        
        print(parameters)
        
        Alamofire.request(URLConstants.kAPI_DriverIssueImage, method: .post, parameters: parameters, encoding: URLEncoding.default)
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
                    responseProtocol.responseError("请求到达失败！")
                    print(error)
                }
        }
    }
}
