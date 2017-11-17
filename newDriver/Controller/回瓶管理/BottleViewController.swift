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
    
    // 厂商信息
    @IBOutlet weak var factoryInfoView: UIView!
    @IBOutlet weak var factoryInfoAddView: UIView!
    
    // 添加客户信息
    @IBAction func customerOnclick(_ sender: UITapGestureRecognizer) {
        print("1")
    }
    
    // 添加客户信息
    @IBAction func factoryOnclick(_ sender: UITapGestureRecognizer) {
        print("2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "回瓶管理"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
