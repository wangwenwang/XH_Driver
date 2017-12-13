//
//  ArrivalsViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class ArrivalsViewController: UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, HttpResponseProtocol {
    
    
    
    func responseSuccess() {
        
        _ = MBProgressHUD.hideHUDForView(UIApplication.shared.keyWindow!, animated: true)
        
        let vcl = navigationController?.viewControllers[0]
        NotPayTableViewController.shouldRefresh = true
        
        let hud: MBProgressHUD = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
        
        // Configure for text only and offset down
        hud.mode = .text
        hud.labelText = "提交订单成功，即将返回..."
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 2)
        
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async {
                _ = self.navigationController?.popToViewController(vcl!, animated: true)
            }
        }
    }
    
    func responseError(_ error: String) {
        
        _ = MBProgressHUD.hideHUDForView(UIApplication.shared.keyWindow!, animated: true)
        Tools.showAlertDialog(error, self)
    }
    

    @IBOutlet weak var onePictureBtn: UIButton!
    @IBOutlet weak var twoPictureBtn: UIButton!
    
    let biz: DriverIssueImageBiz = DriverIssueImageBiz()
    
    // 选择现场图片的角标，1 现场图片1，2 现场图片2
    var currentUpdataPictureIndex: Int = 0
    
    var pickerController : UIImagePickerController? = nil;
    
    // 订单的 idx
    var orderIDX: String = ""
    
    // 现场图片1
    var image1: UIImage? {
        didSet {
            onePictureBtn.setImage(image1, for: .normal)
        }
    }
    
    // 现场图片2
    var image2: UIImage? {
        didSet {
            twoPictureBtn.setImage(image2, for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 创建相册
        createData()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - 函数
    func addPicture() {
        
        let actionSheet : UIActionSheet = UIActionSheet.init(title: "", delegate: self, cancelButtonTitle:"取消", destructiveButtonTitle: nil, otherButtonTitles:"拍照")
        actionSheet.show(in: UIApplication.shared.keyWindow!)
    }
    
    
    // 跳转到imagePicker里
    func makePhoto() {
        
        pickerController?.sourceType = .camera
        self.present(pickerController!, animated: true, completion: nil)
    }
    
    
    // MARK: - 事件
    @IBAction func addOnePictureOnclick() {
        
        currentUpdataPictureIndex = 1
        addPicture()
    }
    
    @IBAction func addTwoPictureOnclick() {
        
        currentUpdataPictureIndex = 2
        addPicture()
    }
    
    @IBAction func cancelOnclick() {
        
        let vcl = navigationController?.viewControllers[0]
        NotPayTableViewController.shouldRefresh = true
        _ = self.navigationController?.popToViewController(vcl!, animated: true)
    }
    
    @IBAction func commitOnclick() {
        
        if image1 == nil {
            Tools.showAlertDialog("请上传现场图片1再提交！", self)
            return
        }
        if image2 == nil {
            Tools.showAlertDialog("请上传现场图片2再提交！", self)
            return
        }
        let image1Str = biz.changeImageToString(image1)
        let image2Str = biz.changeImageToString(image2)
        // 判断连接状态
        let reachability = Reachability.forInternetConnection()
        if reachability!.isReachable() {
            _ = MBProgressHUD.showHUDAddedTo(UIApplication.shared.keyWindow!, animated: true)
            biz.DriverIssueImage(shipment_no: orderIDX, struseridx: (AppDelegate.user?.IDX)!, PictureFile1: image1Str, PictureFile2: image2Str, httpresponseProtocol: self)
        } else {
            self.responseError("网络连接不可用!")
        }
    }
    
    
    // MARK: - 照片
    func createData() {
        
        // 初始化pickerController
        pickerController = UIImagePickerController()
        pickerController?.view.backgroundColor = UIColor.groupTableViewBackground
        pickerController?.delegate = self
        //        pickerController?.allowsEditing = true
    }
    
    
    // MARK: - UIActionSheetDelegate
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        if (buttonIndex == 1) {//相机
            
            if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
                
                NSLog("支持相机")
                makePhoto()
            } else {
                
                let alert : UIAlertView = UIAlertView()
                alert.title = "提示"
                alert.message = "请在设置-->隐私-->相机，中开启本应用的相机访问权限！!"
                alert.delegate = self
                alert.addButton(withTitle: "取消")
                alert.addButton(withTitle: "确定")
                alert.show()
            }
        }
    }
    
    
    // MARK: - 拍照回调
    // 完成拍照
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        if let im = image {
            let data = image?.compressImage(im, maxLength: 1024*100)
            if let da = data {
                image = UIImage(data: da)
            }
        }
        if image != nil {
            switch currentUpdataPictureIndex {
            case 1://添加的是现场图片1
                image1 = image
            case 2://添加的是现场图片2
                image2 = image
            default:
                break
            }
        }
    }
    
    // 取消拍照
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
