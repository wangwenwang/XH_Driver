//
//  ModifyBottleViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class ModifyBottleViewController: UIViewController, HttpResponseProtocol {
    func responseSuccess() {
        
    }
    
    func responseError(_ error: String) {
        
    }
    
    
    public var strIdx: String!
    
    public var list: [BottleItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "修改物品数量"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func modifyOnclick() {
        
        let biz: SetBottleQTYBiz = SetBottleQTYBiz()
        biz.SetBottleQTY(strIdx: list[0].IDX, StrQty: "888", httpresponseProtocol: self)
    }
    @IBAction func nextOnclick() {
        
        let biz: OrderWorkflowBiz = OrderWorkflowBiz()
        biz.OrderWorkflow(stridx: strIdx, ADUT_USER: (AppDelegate.user?.USER_NAME)!, httpresponseProtocol: self)
    }
}
