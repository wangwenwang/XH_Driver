//
//  URLConstants.swift
//  kdyDriver
//
//  Created by 凯东源 on 16/6/24.
//  Copyright © 2016年 凯东源. All rights reserved.
//

import Foundation

struct URLConstants {
    
    /// 通知
    static let kBottleViewController_Notification: String = "BottleViewController_Notification"
    
    /// 服务器地址
    static let baseUrl: String = "http://oms.kaidongyuan.com:12300/api/"
    
    /// app 唯一标识符
    static let appId: String = "1138169586"
    
    /// 文件下载端口和文件夹
    static let loadUrl: String = "http://oms.kaidongyuan.com:12300/"
    
    /// 服务端存放电子签名和现场图片的文件夹
    static let serverAutographAndPictureFile: String = "Uploadfile"
    
    /// 登陆接口
    static let loginUrl: String = URLConstants.baseUrl + "Login"
    
    /// 获取未交付订单列表接口 带时间
    static let API_GetDriverDateOrderClientList: String = URLConstants.baseUrl + "GetDriverDateOrderClientList"
    
    /// 修改登录密码
    static let changePassword: String = URLConstants.baseUrl + "modifyPassword"
    
    /// 获取订单信息详情   GetOrderTmsOrderNoInfo GetOrderTmsInfo
    static let getOrderTmsInfo = URLConstants.baseUrl + "GetOrderTmsOrderNoInfo"
    
    /// 获取最新版本 app 信息
    static let getAppVersionInfo = "https://itunes.apple.com/cn/lookup?id=" + URLConstants.appId
    
    /// 获取签名喝现场图片
    static let getAutographAndPicture = URLConstants.baseUrl + "GetAutograph"
    
    /// 获取订单路线点位集合
    static let getOrderLoacations = URLConstants.baseUrl + "GetLocaltion"
    
    
//    #if DEBUG
//    
//    /// 单点上传位置信息
//    static let updataLocation = URLConstants.baseUrl + "CurrentLocaltion1"
//    
//    /// 上传位置点集合信息
//    static let updataLocations = URLConstants.baseUrl + "CurrentLocaltionList1"
//    
//    /// 上传token
//    static let uploadToken = URLConstants.baseUrl + "SavaPushToken1"
//    #else
    
    /// 单点上传位置信息
    static let updataLocation = URLConstants.baseUrl + "CurrentLocaltion"
    
    /// 上传位置点集合信息
    static let updataLocations = URLConstants.baseUrl + "CurrentLocaltionList"
    
    /// 上传token
    static let uploadToken = URLConstants.baseUrl + "SavaPushToken"
//    #endif
    
    /// 获取推送订单或公告
    static let getPushMessage = URLConstants.baseUrl + "GetMessage"
    
    /// 设置推送消息状态（已读或未读，未读是0，已读是1）
    static let setPushMessageStatus = URLConstants.baseUrl + "GetMessageDetils"
    
    /// 获取物流信息详情
    static let kAPI_GetPrice = URLConstants.baseUrl + "GetPrice"
    
    /// 获取装运编号下属指定状态订单列表
    static let kAPI_GetShipmentUnPayOrderList = URLConstants.baseUrl + "GetShipmentUnPayOrderList"
    
    /// 订单批量到达
    static let kAPI_DriverIssueImage = URLConstants.baseUrl + "DriverIssueImage"
    
    /// 订单批量交付
    static let kAPI_DriverListPay = URLConstants.baseUrl + "DriverListPay"
    
    
    //
    
    /// 回瓶管理
    
    /// 获取地址信息
    static let kAPI_GetReturnPartyList = URLConstants.baseUrl + "GetReturnPartyList"
    
    /// 获取司机信息
    static let kAPI_GetShipmentList = URLConstants.baseUrl + "GetShipmentList"
    
    /// 获取大瓶中瓶小瓶的信息
    static let kAPI_GetReturnProductList = URLConstants.baseUrl + "GetReturnProductList"
    
    /// 司机获取回瓶列表
    static let kAPI_GetReturnBottleList = URLConstants.baseUrl + "GetReturnBottleList"
    
    /// 获取回瓶详情列表
    static let kAPI_GetReturnBottleInfo = URLConstants.baseUrl + "GetReturnBottleInfo"
    
    /// 修改司机发货的瓶的数量
    static let kAPI_SetBottleQTY = URLConstants.baseUrl + "SetBottleQTY"
    
    /// 正向流程
    static let kAPI_OrderWorkflow = URLConstants.baseUrl + "OrderWorkflow"
    
    /// 到厂时间
    static let kAPI_NewToFoctory = URLConstants.baseUrl + "NewToFoctory"
    
    /// 入月台时间
    static let kAPI_INMonth = URLConstants.baseUrl + "INMonth"
    
    /// 出月台时间
    static let kAPI_Month = URLConstants.baseUrl + "Month"
    
    /// 出厂时间
    static let kAPI_NewFoctory = URLConstants.baseUrl + "NewFoctory"
    
    /// 通知刷新回瓶列表
    static let kNotification_BottleListViewController = "Notification_BottleListViewController"
}
