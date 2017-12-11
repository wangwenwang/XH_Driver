//
//  ArrivalsViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class ArrivalsViewController: UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {

    @IBOutlet weak var onePictureBtn: UIButton!
    @IBOutlet weak var twoPictureBtn: UIButton!
    
    // 选择现场图片的角标，1 现场图片1，2 现场图片2
    var currentUpdataPictureIndex: Int = 0
    
    var pickerController : UIImagePickerController? = nil;
    
    // 订单的 idx
    var orderIDX: String = ""
    
    // 现场图片1
    var image1: UIImage? {
        didSet {
            onePictureBtn.imageView?.image = image1
        }
    }
    
    // 现场图片2
    var image2: UIImage? {
        didSet {
            twoPictureBtn.imageView?.image = image2
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
    func addOnePicture() {
        
        let alert : UIAlertController = UIAlertController.init(title: "添加照片", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
            
        }))
    }
    
    
    // MARK: - 事件
    @IBAction func addOnePictureOnclick() {
        
        currentUpdataPictureIndex = 1
        addOnePicture()
    }
    
    @IBAction func addTwoPictureOnclick() {
        
        currentUpdataPictureIndex = 2
        addOnePicture()
    }
    
    @IBAction func commitOnclick() {
        
        if image1 == nil {
            Tools.showAlertDialog("请上上传现场图片1再提交！", self)
            return
        }
        if image2 == nil {
            Tools.showAlertDialog("请上上传现场图片2再提交！", self)
            return
        }
//        let image1Str = biz.changeImageToString(image1)
//        let image2Str = biz.changeImageToString(image2)
//        // 判断连接状态
//        let reachability = Reachability.forInternetConnection()
//        if reachability!.isReachable(){
//            showProgress()
//            biz.payOrderWithPicture(orderIdx: orderIDX, autographStr: autographStr, image1Str: image1Str, image2Str: image2Str, deliveNoStr: deliveStr, httpresponseProtocol: self)
//            isPaySuccess = true
//        }else{
//            self.responseError("网络连接不可用!")
//        }
    }
    
    
    // MARK: - 照片
    func createData() {
        
        // 初始化pickerController
        pickerController = UIImagePickerController()
        pickerController?.view.backgroundColor = UIColor.groupTableViewBackground
        pickerController?.delegate = self
        //        pickerController?.allowsEditing = true
    }
    
    
    // MARK: - 拍照回调
    // 选择图片完成或拍照完成返回信息
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
    
    // 取消选择图片或拍照
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
