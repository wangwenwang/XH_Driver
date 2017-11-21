//
//  SupplierViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/20.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class SupplierViewController: UIViewController, HttpResponseProtocol, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let biz: GetReturnPartyListBiz = GetReturnPartyListBiz()
    
    func responseSuccess() {
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        tableView.reloadData()
    }
    
    func responseError(_ error: String) {
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择厂商"
        
        self.tableView.register(UINib.init(nibName: "SupplierTableViewCell", bundle: nil), forCellReuseIdentifier: "SupplierTableViewCell")
        
        _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        biz.GetReturnPartyList(strUserId: AppDelegate.user!.IDX, strBusinessId: "", strType: "Supplier", httpresponseProtocol: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biz.addressList.count
    }
    
    // 设置 cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let address: BottleAddressList = biz.addressList[(indexPath as NSIndexPath).row]
        return address.cellHeight
    }
    
    // 设置自定义的 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupplierTableViewCell", for: indexPath) as! SupplierTableViewCell
        cell.address = biz.addressList[(indexPath as NSIndexPath).row]
        return cell
    }
    
    // 点击 tableview 的 cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let address: BottleAddressList = biz.addressList[(indexPath as NSIndexPath).row]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: URLConstants.kBottleViewController_Notification), object: nil, userInfo: ["Factory":address])
        self.navigationController?.popViewController(animated: true)
    }
}
