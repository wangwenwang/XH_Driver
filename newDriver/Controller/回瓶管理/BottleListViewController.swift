//
//  BottleListViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HttpResponseProtocol {
    
    
    func responseSuccess() {
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        tableView.reloadData()
    }
    
    func responseError(_ error: String) {
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let biz: GetReturnBottleListBiz = GetReturnBottleListBiz()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "回瓶单列表"
        
        self.tableView.register(UINib.init(nibName: "BottleListTableViewCell", bundle: nil), forCellReuseIdentifier: "BottleListTableViewCell")
        
        _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        biz.GetReturnBottleList(TMS_DRIVER_IDX: (AppDelegate.user?.USER_CODE)!, strType: "NPLY", strPage: "1", strPageCount: "999", httpresponseProtocol: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biz.orders.count
    }
    
    // 设置 cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let order: BottleOrder = biz.orders[(indexPath as NSIndexPath).row]
        return order.cellHeight
    }
    
    // 设置自定义的 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleListTableViewCell", for: indexPath) as! BottleListTableViewCell
        cell.order = biz.orders[(indexPath as NSIndexPath).row]
        return cell
    }
    
    // 点击 tableview 的 cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let order: BottleOrder = biz.orders[(indexPath as NSIndexPath).row]
        
        let vc: BottleInfoViewController = BottleInfoViewController(nibName: "BottleInfoViewController", bundle: nil)
        vc.ORDER_IDX = order.IDX
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
