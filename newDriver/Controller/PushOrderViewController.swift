//
//  PushOrderViewController.swift
//  newDriver
//
//  Created by 凯东源 on 16/12/15.
//  Copyright © 2016年 凯东源. All rights reserved.
//

import UIKit

class PushOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var SHIPMENT_List: [SHIPMENT_List] = []
    var shipmentIdx: String!
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.myTableView.register(UINib.init(nibName: "PushOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PushOrderTableViewCell")
        self.myTableView.rowHeight = 108
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 事件   生成装运二维码
    @IBAction func shipmentQRCodeOnclick() {
        
        let vc = OrderQRCodeViewController(nibName:"OrderQRCodeViewController", bundle: nil)
        vc.TMS_SHIPMENT_NO = shipmentIdx
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SHIPMENT_List.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order: SHIPMENT_List = SHIPMENT_List[(indexPath as NSIndexPath).row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PushOrderTableViewCell", for: indexPath) as! PushOrderTableViewCell
        cell.titleLabel.text = order.ORD_NO
        cell.ORD_NO_CLIENT.text = order.ORD_NO_CLIENT
        cell.ORD_TYPE.text = order.ORD_TYPE
        cell.ORD_TO_NAME.text = order.ORD_TO_NAME
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
        
        let orderDetailController : OrderDetailViewController? = OrderDetailViewController(nibName:"OrderDetailViewController", bundle:nil)
        
        let pushOrderSimple: SHIPMENT_List = SHIPMENT_List[(indexPath as NSIndexPath).row]
        
        let order: SHIPMENT_List = SHIPMENT_List[indexPath.row]
        if(order.ORD_TYPE == "回瓶运输" && order.ORD_TYPE_HANDLING == "RECEIPT") {
            
            let vc: BottleInfoViewController = BottleInfoViewController(nibName: "BottleInfoViewController", bundle: nil)
            vc.ORDER_IDX = pushOrderSimple.ORD_IDX
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
            if let ODVC = orderDetailController {
                ODVC.orderIDX = pushOrderSimple.ORD_IDX
                self.navigationController?.pushViewController(ODVC, animated: true)
            } else {
                Tools.showAlertDialog("orderDetailController = nil", self)
            }
        }
    }
}

