//
//  BottleViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/17.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleViewController: UIViewController, HttpResponseProtocol {
    
    
    func responseSuccess() {
        print("okok")
    }
    
    func responseError(_ error: String) {
        print("nono")
    }
    
    
    // 客户信息
    var customer: BottleAddressList!
    @IBOutlet weak var customerInfoView: UIView!
    @IBOutlet weak var customerInfoAddView: UIView!
    // 客户名称
    @IBOutlet weak var customer_NAME: UILabel!
    // 客户地址
    @IBOutlet weak var customer_ADDRESS: UILabel!
    // 客户联系人
    @IBOutlet weak var customer_PERSON: UILabel!
    // 客户电话
    @IBOutlet weak var customer_TEL: UILabel!
    @IBOutlet weak var modifyCustomerBtn: UIButton!
    @IBOutlet weak var customerViewHeight: NSLayoutConstraint!
    var customerViewHeight_static: CGFloat = 0
    
    // 厂商信息
    var factory: BottleAddressList!
    @IBOutlet weak var factoryInfoView: UIView!
    @IBOutlet weak var factoryInfoAddView: UIView!
    // 供应商名称
    @IBOutlet weak var PARTY_NAME: UILabel!
    // 供应商地址
    @IBOutlet weak var PARTY_ADDRESS: UILabel!
    // 供应商代码
    var Supplier_BUSINESS_IDX: String! = ""
    @IBOutlet weak var modifyFactoryBtn: UIButton!
    
    // 承运信息
    var carrier: Carrier!
    @IBOutlet weak var carrierInfoView: UIView!
    @IBOutlet weak var carrierInfoAddView: UIView!
    // 车牌号
    @IBOutlet weak var TMS_PLATE_NUMBER: UILabel!
    // 车辆类型
    @IBOutlet weak var TMS_VEHICLE_TYPE: UILabel!
    // 司机姓名
    @IBOutlet weak var TMS_DRIVER_NAME: UILabel!
    // 司机联系电话
    @IBOutlet weak var TMS_DRIVER_TEL: UILabel!
    // 承运商
    @IBOutlet weak var TMS_FLEET_NAME: UILabel!
    
    // 瓶子信息
    let biz: GetReturnProductListBiz = GetReturnProductListBiz()
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "回瓶管理"
        
        initUI()
        addNotification()
        customerViewHeight_static = customerViewHeight.constant
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        removeNotification()
    }
    
    // MARK: - 函数
    func initUI() {
        PARTY_NAME.text = ""
        PARTY_ADDRESS.text = ""
        customer_NAME.text = ""
        customer_ADDRESS.text = ""
        customer_PERSON.text = ""
        customer_TEL.text = ""
    }
    
    func addCustomer() {
        let vc: ConsigneeViewController = ConsigneeViewController(nibName: "SupplierViewController", bundle: nil)
        vc.BUSINESS_IDX = Supplier_BUSINESS_IDX
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addFactory() {
        self.navigationController?.pushViewController(SupplierViewController(nibName: "SupplierViewController", bundle: nil), animated: true)
    }
    
    func addCarrier() {
        self.navigationController?.pushViewController(CarrierViewController(nibName: "CarrierViewController", bundle: nil), animated: true)
    }
    
    // MARK: - 手势
    // 添加客户信息
    @IBAction func customerOnclick(_ sender: UITapGestureRecognizer) {
        addCustomer()
    }
    
    // 添加厂商信息
    @IBAction func factoryOnclick(_ sender: UITapGestureRecognizer) {
        addFactory()
    }
    
    // 添加承运信息
    @IBAction func carrierOnclick(_ sender: UITapGestureRecognizer) {
        addCarrier()
    }
    
    // MARK: - 事件
    @IBAction func modityCustomerOnclick(_ sender: UIButton) {
        addCustomer()
    }
    
    @IBAction func modityFactoryOnclick(_ sender: UIButton) {
        addFactory()
    }
    
    @IBAction func commitOnclick(_ sender: UIButton) {
        let detail = ["PRODUCT_NO" : "odr",
                      "OrderDetails" : "odr"
                      ]
    }
    
    // MARK: - 通知
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAddress(_:)), name: NSNotification.Name(rawValue: URLConstants.kBottleViewController_Notification), object: nil)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: URLConstants.kBottleViewController_Notification), object: nil)
    }
    
    func reloadAddress(_ aNotify: Notification) {
        if((aNotify.userInfo!["Factory"]) != nil) {
            factory = aNotify.userInfo!["Factory"] as! BottleAddressList
            factoryInfoAddView.isHidden = true
            factoryInfoView.isHidden = false
            modifyFactoryBtn.isHidden = false
            PARTY_NAME.text = factory.PARTY_NAME
            PARTY_ADDRESS.text = factory.PARTY_PROVINCE + factory.PARTY_CITY
            Supplier_BUSINESS_IDX = factory.BUSINESS_IDX
            biz.GetReturnProductList(strBusinessId: factory.BUSINESS_IDX, httpresponseProtocol: self)
        }
        else if((aNotify.userInfo!["Customer"]) != nil) {
            customer = aNotify.userInfo!["Customer"] as! BottleAddressList
            customerInfoAddView.isHidden = true
            customerInfoView.isHidden = false
            modifyCustomerBtn.isHidden = false
            customer_NAME.text = customer.PARTY_NAME
            customer_ADDRESS.text = customer.PARTY_PROVINCE + customer.PARTY_CITY
            customer_PERSON.text = customer.CONTACT_PERSON
            customer_TEL.text = customer.CONTACT_TEL
            let oneLine = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
//            customer_NAME.sizeToFit()
//            let mulLine = customer_NAME.frame.height // 有bug
            let mulLine = Tools.getHeightOfString(text: customer_NAME.text!, fontSize: 15, width: (SCREEN_WIDTH - (8 + 46 + 3 - 2)))
            customerViewHeight.constant = customerViewHeight_static + (mulLine - oneLine)
        }
        else if((aNotify.userInfo!["Carrier"]) != nil) {
            carrier = aNotify.userInfo!["Carrier"] as! Carrier
            carrierInfoAddView.isHidden = true
            carrierInfoView.isHidden = false
            TMS_PLATE_NUMBER.text = carrier.TMS_PLATE_NUMBER
            TMS_VEHICLE_TYPE.text = carrier.TMS_VEHICLE_TYPE + "  " + carrier.TMS_VEHICLE_SIZE
            TMS_DRIVER_NAME.text = carrier.TMS_DRIVER_NAME
            TMS_DRIVER_TEL.text = carrier.TMS_DRIVER_TEL
            TMS_FLEET_NAME.text = carrier.TMS_FLEET_NAME
        }
    }
}
