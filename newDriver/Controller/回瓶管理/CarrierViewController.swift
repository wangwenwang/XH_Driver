//
//  CarrierViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class CarrierViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, HttpResponseProtocol {
    
    
    func responseSuccess() {
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        print(biz.carrierList)
        tableView.reloadData()
    }
    
    func responseError(_ error: String) {
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let biz: GetShipmentListBiz = GetShipmentListBiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "承运商列表"
        
        self.tableView.register(UINib.init(nibName: "CarrierTableViewCell", bundle: nil), forCellReuseIdentifier: "CarrierTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biz.carrierList.count
    }
    
    // 设置 cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let carrier: Carrier = biz.carrierList[(indexPath as NSIndexPath).row]
        return carrier.cellHeight
    }
    
    // 设置自定义的 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarrierTableViewCell", for: indexPath) as! CarrierTableViewCell
        cell.carrier = biz.carrierList[(indexPath as NSIndexPath).row]
        return cell
    }
    
    // 点击 tableview 的 cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let carrier: Carrier = biz.carrierList[(indexPath as NSIndexPath).row]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: URLConstants.kBottleViewController_Notification), object: nil, userInfo: ["Carrier":carrier])
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        self.view.endEditing(true)
        _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let tel = searchBar.text
        if let aTel = tel {
            biz.carrierList.removeAll()
            biz.GetShipmentList(TMS_DRIVER_CODE: aTel, httpresponseProtocol: self)
        }
    }
}
