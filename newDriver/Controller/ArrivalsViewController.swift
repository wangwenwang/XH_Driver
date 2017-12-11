//
//  ArrivalsViewController.swift
//  newDriver
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

import UIKit

class ArrivalsViewController: UIViewController {

    @IBOutlet weak var onePictureBtn: UIButton!
    @IBOutlet weak var twoPictureBtn: UIButton!
    
    /// 订单的 idx
    var orderIDX: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
    @IBAction func addOnePictureOnclick(_ sender: UIButton) {
        
        addOnePicture()
    }
    
    @IBAction func addTwoPictureOnclick(_ sender: UIButton) {
        
    }
}
