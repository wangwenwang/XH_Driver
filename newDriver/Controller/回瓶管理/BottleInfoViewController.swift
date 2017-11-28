//
//  BottleInfoViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/11/23.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class BottleInfoViewController: UIViewController, HttpResponseProtocol, UITableViewDataSource, UITableViewDelegate {
    
    // 修改数量成功次数
    var requestSuccessCount: Int = 0
    var requestBottleInfoOK: Bool = false
    
    func responseSuccess_audit() {
        
        _ = MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
        let hud: MBProgressHUD = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
        
        // Configure for text only and offset down
        hud.mode = .text
        hud.labelText = "订单已确认，即将返回..."
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 2)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: URLConstants.kNotification_BottleListViewController), object: nil)
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func responseError_audit(_ error: String) {
        
        _ = MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        Tools.showAlertDialog("确认失败", self)
    }
    
    func responseSuccess() {
        
        // 网络层bug，多个请求没写多个回调
        if(requestBottleInfoOK == false) {
            
            _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
            tableView.reloadData()
            let overHeiht: CGFloat = 100 - CGFloat((biz.bottleDetail?.List.count)!) * kCellHeight - 30
            bottleInfoViewHeight.constant = bottleInfoViewHeight.constant - overHeiht
            scrollContentViewHeight.constant = scrollContentViewHeight.constant - overHeiht
            
            customer_NAME.text = " "
            customer_ADDRESS.text = biz.bottleDetail?.Info?.ORD_FROM_ADDRESS
            customer_PERSON.text = biz.bottleDetail?.Info?.ORD_FROM_CNAME
            customer_TEL.text = biz.bottleDetail?.Info?.ORD_FROM_CTEL
            let oneLine: CGFloat = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
            let mulLine: CGFloat = Tools.getHeightOfString(text: (biz.bottleDetail!.Info?.ORD_FROM_ADDRESS)!, fontSize: 15, width: SCREEN_WIDTH - 8 - 46 + 2 - 3)
            customerViewHeight.constant += (mulLine - oneLine)
            
            PARTY_NAME.text = " "
            PARTY_ADDRESS.text = biz.bottleDetail?.Info?.ORD_TO_ADDRESS
            
            TMS_PLATE_NUMBER.text = biz.bottleDetail?.Info?.TMS_PLATE_NUMBER
            TMS_VEHICLE_TYPE.text = biz.bottleDetail?.Info?.TMS_VEHICLE_TYPE
            TMS_DRIVER_NAME.text = biz.bottleDetail?.Info?.TMS_DRIVER_NAME
            TMS_DRIVER_TEL.text = biz.bottleDetail?.Info?.TMS_DRIVER_TEL
            TMS_FLEET_NAME.text = biz.bottleDetail?.Info?.TMS_FLEET_NAME
            
            
            if(biz.bottleDetail?.Info?.ORD_WORKFLOW == "新建" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已审核" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已释放" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已装运" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已确认") {
                confirmBtn.isHidden = false
            }
            requestBottleInfoOK = true
        } else {
            
            requestSuccessCount = requestSuccessCount + 1
            if(requestSuccessCount == biz.bottleDetail?.List.count) {
                
                //                Tools.showAlertDialog("数量修改完毕，执行正向流程", self)
                
                let biz_audit: OrderWorkflowBiz = OrderWorkflowBiz()
                biz_audit.OrderWorkflow(stridx: (biz.bottleDetail?.Info?.IDX)!, ADUT_USER: (AppDelegate.user?.USER_NAME)!, httpresponseProtocol: self)
            }
        }
        
        ORD_WORKFLOW.text = biz.bottleDetail?.Info?.ORD_WORKFLOW
        ORD_DATE_ADD.text = biz.bottleDetail?.Info?.ORD_DATE_ADD
    }
    
    func responseError(_ error: String) {
        
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    
    public var ORDER_IDX: String!
    
    let biz: GetReturnBottleInfoBiz = GetReturnBottleInfoBiz()
    
    // 客户名称
    @IBOutlet weak var customer_NAME: UILabel!
    // 客户地址
    @IBOutlet weak var customer_ADDRESS: UILabel!
    // 客户联系人
    @IBOutlet weak var customer_PERSON: UILabel!
    // 客户电话
    @IBOutlet weak var customer_TEL: UILabel!
    @IBOutlet weak var customerViewHeight: NSLayoutConstraint!
    var customerViewHeight_static: CGFloat = 0
    
    // 供应商名称
    @IBOutlet weak var PARTY_NAME: UILabel!
    // 供应商地址
    @IBOutlet weak var PARTY_ADDRESS: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottleInfoViewHeight: NSLayoutConstraint!
    var kCellHeight: CGFloat = 44
    
    // 工作流程
    @IBOutlet weak var ORD_WORKFLOW: UILabel!
    @IBOutlet weak var ORD_DATE_ADD: UILabel!
    
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
    
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var scrollContentViewHeight: NSLayoutConstraint!
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "订单详情"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "BottleInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "BottleInfoTableViewCell")
        
        initUI()
        
        _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        biz.GetReturnBottleInfo(ORDER_IDX: ORDER_IDX, httpresponseProtocol: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 函数
    func initUI() {
        customer_NAME.text = " "
        customer_ADDRESS.text = " "
        customer_PERSON.text = " "
        customer_TEL.text = " "
        
        PARTY_NAME.text = " "
        PARTY_ADDRESS.text = " "
        
        ORD_WORKFLOW.text = " "
        ORD_DATE_ADD.text = " "
        
        TMS_PLATE_NUMBER.text = " "
        TMS_VEHICLE_TYPE.text = " "
        TMS_DRIVER_NAME.text = " "
        TMS_DRIVER_TEL.text = " "
        TMS_FLEET_NAME.text = " "
    }
    
    // MARK: - 事件
    @IBAction func confirmOnclick() {
        
        if(biz.bottleDetail?.Info?.ORD_WORKFLOW == "新建" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已审核" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已释放" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已装运") {
            Tools.showAlertDialog("系统流程出错，请系统客服", self)
        } else if(biz.bottleDetail?.Info?.ORD_WORKFLOW == "已确认") {
            
            var i: Int = 0
            var isReturn = false
            for _ in (biz.bottleDetail?.List)! {
                let indexPath: NSIndexPath = NSIndexPath.init(item: i, section: 0)
                let cell: BottleInfoTableViewCell = self.tableView.cellForRow(at: indexPath as IndexPath) as! BottleInfoTableViewCell
                i = i + 1
                if(cell.qtyF.text?.isEmpty)! {
                    isReturn = true
                    break
                }
            }
            
            if(isReturn) {
                Tools.showAlertDialog("请确认数量", self)
            } else {
                _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                requestSuccessCount = 0;
                let service: SetBottleQTYBiz = SetBottleQTYBiz()
                for b in (biz.bottleDetail?.List)! {
                    service.SetBottleQTY(strIdx: b.IDX, StrQty: b.ISSUE_QTY, httpresponseProtocol: self)
                }
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (biz.bottleDetail != nil) ? biz.bottleDetail!.List.count : 0
    }
    
    // 设置 cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 设置自定义的 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleInfoTableViewCell", for: indexPath) as! BottleInfoTableViewCell
        cell.ORD_WORKFLOW = (biz.bottleDetail?.Info?.ORD_WORKFLOW)!
        cell.bottle = biz.bottleDetail?.List[(indexPath as NSIndexPath).row]
        return cell
    }
}
