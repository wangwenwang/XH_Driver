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
        Tools.showAlertDialog(error, self)
    }
    
    func responseSuccess() {
        
        // 网络层bug，多个请求没写多个回调
        if(requestBottleInfoOK == false) {
            
            _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
            tableView.reloadData()
            
            // 客户信息
            customer_NAME.text = biz.bottleDetail?.Info?.ORD_FROM_NAME
            customer_ADDRESS.text = biz.bottleDetail?.Info?.ORD_FROM_ADDRESS
            customer_PERSON.text = biz.bottleDetail?.Info?.ORD_FROM_CNAME
            customer_TEL.text = biz.bottleDetail?.Info?.ORD_FROM_CTEL
            let oneLine: CGFloat = Tools.getHeightOfString(text: "fds", fontSize: 15, width: CGFloat(MAXFLOAT))
            var mulLine: CGFloat = Tools.getHeightOfString(text: (biz.bottleDetail!.Info?.ORD_FROM_ADDRESS)!, fontSize: 15, width: SCREEN_WIDTH - 8 - 39 - 3)
            customerViewHeight.constant += (mulLine - oneLine)
            
            // 厂家信息
            PARTY_NAME.text = biz.bottleDetail?.Info?.ORD_TO_NAME
            PARTY_ADDRESS.text = biz.bottleDetail?.Info?.ORD_TO_ADDRESS
            ORD_TO_CNAME.text = biz.bottleDetail?.Info?.ORD_TO_CNAME
            ORD_TO_CTEL.text = biz.bottleDetail?.Info?.ORD_TO_CTEL
            mulLine = Tools.getHeightOfString(text: PARTY_NAME.text!, fontSize: 15, width: SCREEN_WIDTH - 8 - 39 - 3)
            factoryViewHeight.constant += (mulLine - oneLine)
            
            // 物流信息
            ORD_WORKFLOW.text = biz.bottleDetail?.Info?.ORD_WORKFLOW
            ORD_DATE_ADD.text = biz.bottleDetail?.Info?.ORD_DATE_ADD
            
            // 货物信息
            bottleInfoViewHeight.constant = 30 + (biz.bottleDetail?.Info?.tableViewHeight)!
            
            // 承运信息
            TMS_PLATE_NUMBER.text = biz.bottleDetail?.Info?.TMS_PLATE_NUMBER
            TMS_VEHICLE_TYPE.text = biz.bottleDetail?.Info?.TMS_VEHICLE_TYPE
            TMS_DRIVER_NAME.text = biz.bottleDetail?.Info?.TMS_DRIVER_NAME
            TMS_DRIVER_TEL.text = biz.bottleDetail?.Info?.TMS_DRIVER_TEL
            TMS_FLEET_NAME.text = biz.bottleDetail?.Info?.TMS_FLEET_NAME
            mulLine = Tools.getHeightOfString(text: TMS_FLEET_NAME.text!, fontSize: 15, width: SCREEN_WIDTH - 8 - 69.5 - 3)
            carrierViewHeight.constant += (mulLine - oneLine)
            
            var bottomViewHeight: CGFloat = 90
            if(biz.bottleDetail?.Info?.ORD_WORKFLOW == "新建" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已审核" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已释放" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已装运" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已确认") {
                bottomViewHeight = 90
                confirmBtn.setTitle("确认", for: .normal)
            } else {
                bottomViewHeight = 90
                confirmBtn.setTitle("生成二维码", for: .normal)
            }
            requestBottleInfoOK = true
            scrollContentViewHeight.constant = customerViewHeight.constant +
                factoryViewHeight.constant +
                logisticsViewHeight.constant +
                bottleInfoViewHeight.constant +
                carrierViewHeight.constant +
            bottomViewHeight
        } else {
            requestSuccessCount = requestSuccessCount + 1
            if(requestSuccessCount == biz.bottleDetail?.List.count) {
                let biz_audit: OrderWorkflowBiz = OrderWorkflowBiz()
                biz_audit.OrderWorkflow(stridx: (biz.bottleDetail?.Info?.IDX)!, ADUT_USER: (AppDelegate.user?.USER_NAME)!, httpresponseProtocol: self)
            }
        }
    }
    
    func responseError(_ error: String) {
        
        _ = MBProgressHUD.hideHUDForView(self.view, animated: true)
        Tools.showAlertDialog(error, self)
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
    
    // 供应商名称
    @IBOutlet weak var PARTY_NAME: UILabel!
    // 供应商地址
    @IBOutlet weak var PARTY_ADDRESS: UILabel!
    // 供应商联系人
    @IBOutlet weak var ORD_TO_CNAME: UILabel!
    // 供应商电话
    @IBOutlet weak var ORD_TO_CTEL: UILabel!
    
    @IBOutlet weak var factoryViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottleInfoViewHeight: NSLayoutConstraint!
    
    // 工作流程
    @IBOutlet weak var ORD_WORKFLOW: UILabel!
    @IBOutlet weak var ORD_DATE_ADD: UILabel!
    @IBOutlet weak var logisticsViewHeight: NSLayoutConstraint!
    
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
    @IBOutlet weak var carrierViewHeight: NSLayoutConstraint!
    
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
        ORD_TO_CNAME.text = " "
        ORD_TO_CTEL.text = " "
        
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
        
        if(biz.bottleDetail?.Info?.ORD_WORKFLOW == "新建" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已审核" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已释放" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已装运" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已确认") {
            
            if(biz.bottleDetail?.Info?.ORD_WORKFLOW == "新建" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已审核" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已释放" || biz.bottleDetail?.Info?.ORD_WORKFLOW == "已装运") {
                Tools.showAlertDialog("系统流程出错，请联系客服", self)
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
                    requestSuccessCount = 0
                    let service: SetBottleQTYBiz = SetBottleQTYBiz()
                    for b in (biz.bottleDetail?.List)! {
                        service.SetBottleQTY(strIdx: b.IDX, StrQty: b.ISSUE_QTY, httpresponseProtocol: self)
                    }
                }
            }
        } else {
            let vc = OrderQRCodeViewController(nibName:"OrderQRCodeViewController", bundle: nil)
            vc.TMS_SHIPMENT_NO = biz.bottleDetail?.Info?.TMS_SHIPMENT_NO
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (biz.bottleDetail != nil) ? biz.bottleDetail!.List.count : 0
    }
    
    // 设置 cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = biz.bottleDetail?.List[(indexPath as NSIndexPath).row]
        return (item?.cellHeight)!
    }
    
    // 设置自定义的 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleInfoTableViewCell", for: indexPath) as! BottleInfoTableViewCell
        cell.ORD_WORKFLOW = (biz.bottleDetail?.Info?.ORD_WORKFLOW)!
        cell.bottle = biz.bottleDetail?.List[(indexPath as NSIndexPath).row]
        return cell
    }
}
