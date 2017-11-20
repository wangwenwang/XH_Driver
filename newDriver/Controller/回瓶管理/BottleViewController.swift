//
//  BottleViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/17.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleViewController: UIViewController {
    
    // 客户信息
    @IBOutlet weak var customerInfoView: UIView!
    @IBOutlet weak var customerInfoAddView: UIView!
    // 客户名称
    @IBOutlet weak var customer_NAME: UILabel!
    // 客户地址
    @IBOutlet weak var customer_ADDRESS: UILabel!
    
    // 厂商信息
    @IBOutlet weak var factoryInfoView: UIView!
    @IBOutlet weak var factoryInfoAddView: UIView!
    // 供应商名称
    @IBOutlet weak var PARTY_NAME: UILabel!
    // 供应商地址
    @IBOutlet weak var PARTY_ADDRESS: UILabel!
    // 供应商代码
    var Supplier_BUSINESS_IDX: String! = ""
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "回瓶管理"
        
        addNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        removeNotification()
    }
    
    // MARK: - 函数
    func addCustomer() {
        let vc: ConsigneeViewController = ConsigneeViewController(nibName: "SupplierViewController", bundle: nil)
        vc.BUSINESS_IDX = Supplier_BUSINESS_IDX
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func factory() {
        self.navigationController?.pushViewController(SupplierViewController(nibName: "SupplierViewController", bundle: nil), animated: true)
    }
    
    // MARK: - 手势
    // 添加客户信息
    @IBAction func customerOnclick(_ sender: UITapGestureRecognizer) {
        addCustomer()
    }
    
    // 添加厂商信息
    @IBAction func factoryOnclick(_ sender: UITapGestureRecognizer) {
        factory()
    }
    
    // MARK: - 事件
    @IBAction func modityCustomerOnclick(_ sender: UIButton) {
        addCustomer()
    }
    
    @IBAction func modityFactoryOnclick(_ sender: UIButton) {
        factory()
    }
    
    // MARK: - 通知
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAddress(_:)), name: NSNotification.Name(rawValue: URLConstants.kBottleViewController_Notification), object: nil)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: URLConstants.kBottleViewController_Notification), object: nil)
    }
    
    func reloadAddress(_ aNotify: Notification) {
        if((aNotify.userInfo!["Supplier_Name"]) != nil) {
            factoryInfoAddView.isHidden = true
            factoryInfoView.isHidden = false
            PARTY_NAME.text = aNotify.userInfo!["Supplier_Name"] as? String
            PARTY_ADDRESS.text = aNotify.userInfo!["Supplier_Address"] as? String
            Supplier_BUSINESS_IDX = aNotify.userInfo!["Supplier_BUSINESS_IDX"] as? String
        }
        if((aNotify.userInfo!["Consignee_Name"]) != nil) {
            customerInfoAddView.isHidden = true
            customerInfoView.isHidden = false
            customer_NAME.text = aNotify.userInfo!["Supplier_Name"] as? String
            customer_ADDRESS.text = aNotify.userInfo!["Supplier_Address"] as? String
        }
    }
}
