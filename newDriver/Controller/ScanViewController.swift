//
//  ScanViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit
import AVFoundation

private let scanAnimationDuration = 3.0 //扫描时长

class ScanViewController: UIViewController, HttpResponseProtocol {
    
    func responseSuccess() {
        
        weak var weakSelf = self
        if let wkSelf = weakSelf {
            Tool.confirm(title: "扫描结果", message: biz.msg!, controller: self,handler: { (_) in
                wkSelf.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    func responseError(_ error: String) {
        
        Tools .showAlertDialog(biz.msg!, self);
        self.startScan()
    }
    

    // MARK: - 全局变量
    @IBOutlet weak var scanPane: UIImageView! //扫描框
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var lightOn = false //开光灯
    
    // 二维码类型
    var qrCodeType: Int! = 0
    // 订单id
    var orderIdx: String!
    
    let biz: NewToFoctoryBiz = NewToFoctoryBiz()

    // MARK: - 懒加载
    lazy var scanLine : UIImageView =
        {
            self.scanPane.sizeToFit()
            let scanLine = UIImageView()
            scanLine.frame = CGRect(x: 0, y: 0, width: self.scanPane.bounds.width, height: 3)
            scanLine.image = UIImage(named: "QRCode_ScanLine")
            return scanLine
    }()
    
    var scanSession :  AVCaptureSession?
    
    // MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "入厂扫码"
        
        view.layoutIfNeeded()
        scanPane.addSubview(scanLine)
        setupScanSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScan()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 初始化扫一扫
    func setupScanSession() {
        do {
            //设置捕捉设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            //设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self as AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
            
            //设置会话
            let  scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input) {
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output) {
                scanSession.addOutput(output)
            }
            
            //设置扫描类型(二维码和条形码)
            output.metadataObjectTypes = [
                AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeCode39Code,
                AVMetadataObjectTypeCode128Code,
                AVMetadataObjectTypeCode39Mod43Code,
                AVMetadataObjectTypeEAN13Code,
                AVMetadataObjectTypeEAN8Code,
                AVMetadataObjectTypeCode93Code]
            
            // 预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer!.frame = view.layer.bounds
            
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)
            
            // 设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: self.scanPane.frame))!
            })
            // 保存会话
            self.scanSession = scanSession
        }
        catch {
            // 摄像头不可用
            Tool.confirm(title: "温馨提示", message: "摄像头不可用", controller: self)
            return
        }
    }
    
    // MARK: - 事件
    @IBAction func light(_ sender: UIButton) {
        
        lightOn = !lightOn
        sender.isSelected = lightOn
        turnTorchOn()
    }
    
    // 开始扫描
    fileprivate func startScan() {
        
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else { return }
        
        if !scanSession.isRunning {
            scanSession.startRunning()
        }
    }
    
    //扫描动画
    private func scanAnimation() -> CABasicAnimation {
        
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanPane.bounds.size.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    // 闪光灯
    private func turnTorchOn() {
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else {
            if lightOn {
                Tool.confirm(title: "温馨提示", message: "闪光灯不可用", controller: self)
            }
            return
        }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if lightOn && device.torchMode == .off {
                    device.torchMode = .on
                }
                if !lightOn && device.torchMode == .on {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            }
            catch{ }
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjects Delegate 扫描捕捉完成
extension ScanViewController : AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // 停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        // 播放声音
        Tool.playAlertSound(sound: "noticeMusic.caf")
        
        // 扫完完成
        if metadataObjects.count > 0 {
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject  {
                if(qrCodeType == 0) {
                    
                    // 记录入厂时间
                    self.biz.ToFoctory(andstridx: "", andDriverIdx: (AppDelegate.user?.IDX)!, andFromCode: resultObj.stringValue, andAPI: URLConstants.kAPI_NewToFoctory, httpresponseProtocol: self)
                } else if(qrCodeType == 1) {
                    
                    // 记录入月台时间
                    self.biz.ToFoctory(andstridx: orderIdx, andDriverIdx: (AppDelegate.user?.IDX)!, andFromCode: resultObj.stringValue, andAPI: URLConstants.kAPI_INMonth, httpresponseProtocol: self)
                } else if(qrCodeType == 2) {
                    
                    // 记录出月台时间
                    self.biz.ToFoctory(andstridx: orderIdx, andDriverIdx: (AppDelegate.user?.IDX)!, andFromCode: resultObj.stringValue, andAPI: URLConstants.kAPI_Month, httpresponseProtocol: self)
                } else if(qrCodeType == 3) {
                    
                    // 记录出厂时间
                    self.biz.ToFoctory(andstridx: orderIdx, andDriverIdx: (AppDelegate.user?.IDX)!, andFromCode: resultObj.stringValue, andAPI: URLConstants.kAPI_NewFoctory, httpresponseProtocol: self)
                }
            }
        }
    }
}
