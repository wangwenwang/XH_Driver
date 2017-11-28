//
//  BottleListViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HttpResponseProtocol {
    
    let pageCount: String! = "20"
    var viewWillAppear_refresh: Bool = true
    
    func responseSuccess() {
        self.tableView.reloadData()
        self.tableView.removeNoOrderPrompt()
        self.tableView.es_stopPullToRefresh(completion: true)
        self.tableView.es_stopLoadingMore()
        self.viewWillAppear_refresh = false
        
        if(eSRefreshFooterView == nil) {
            if(self.biz.orders.count >= self.biz.page) {
                eSRefreshFooterView =  self.tableView.es_addInfiniteScrolling {
                    //判断连接状态
                    let reachability = Reachability.forInternetConnection()
                    if reachability!.isReachable(){
                        self.biz.tempPage = self.biz.page + 1
                        self.biz.GetReturnBottleList(TMS_DRIVER_IDX: (AppDelegate.user?.USER_CODE)!, strType: "NPLY", strPageCount: self.pageCount, httpresponseProtocol: self)
                    }else{
                        self.responseError("网络连接不可用!")
                    }
                }
            }
        }
    }
    
    func responseSuccess_noData() {
        self.tableView.es_stopPullToRefresh(completion: true)
        if(eSRefreshFooterView != nil) {
            self.tableView.es_noticeNoMoreData()
            eSRefreshFooterView.animator?.setloadingMoreDescription1("\(biz.orders.count)")
        }
        
        if(biz.orders.count == 0) {
            self.tableView.es_stopLoadingMore()
            tableView.noOrder(title: "您还没有未交付订单")
        } else {
            tableView.removeNoOrderPrompt()
        }
    }
    
    func responseError(_ error: String) {
        tableView.reloadData()
        self.tableView.es_stopPullToRefresh(completion: true)
        self.tableView.es_stopLoadingMore()
        Tools.showAlertDialog(error, self)
    }
    
    
    let biz: GetReturnBottleListBiz = GetReturnBottleListBiz()
    @IBOutlet weak var tableView: UITableView!
    var eSRefreshFooterView : ESRefreshFooterView! = nil
    fileprivate func initRefreshView () {
        _ = self.tableView.es_addPullToRefresh {
            self.biz.tempPage = 1
            //判断连接状态
            let reachability = Reachability.forInternetConnection()
            if reachability!.isReachable(){
                self.biz.GetReturnBottleList(TMS_DRIVER_IDX: (AppDelegate.user?.USER_CODE)!, strType: "NPLY", strPageCount: self.pageCount, httpresponseProtocol: self)
            }else{
                self.responseError("网络连接不可用!")
            }
        }
        self.tableView.refreshIdentifier = NSStringFromClass(BottleListViewController.self) // Set refresh identifier
        self.tableView.expriedTimeInterval = 20.0 // 20 second alive.
    }
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "回瓶单列表"
        self.navigationController?.navigationBar.isTranslucent = false
        
        addNotification()
        
        self.tableView.register(UINib.init(nibName: "BottleListTableViewCell", bundle: nil), forCellReuseIdentifier: "BottleListTableViewCell")
        
        initRefreshView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(viewWillAppear_refresh) {
            self.tableView.es_startPullToRefresh()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeNotification()
    }
    
    // MARK: - 通知
    func addNotification () {
        NotificationCenter.default.addObserver(self, selector: #selector(BottleListViewController.reloadUI), name:NSNotification.Name(rawValue: URLConstants.kNotification_BottleListViewController), object: nil)
    }
    
    func removeNotification () {
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadUI() {
        viewWillAppear_refresh = true
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
