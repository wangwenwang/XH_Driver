//
//  MineTableViewController.swift
//  kdyDriver
//
//  Created by 凯东源 on 16/6/24.
//  Copyright © 2016年 凯东源. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    /// 用户姓名
    @IBOutlet weak var userNameField: UILabel!
    
    /// 用户角色
    @IBOutlet weak var userTypeField: UILabel!
    
    /// 版本号
    @IBOutlet weak var versionField: UILabel! {
        didSet {
            versionField.text = appUtils.getAppVersion()
        }
    }
    
    // 跳转到修改密码界面
    @IBAction func skipToChangePassword(_ sender: UIButton) {
        self.navigationController?.pushViewController(ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "我的"
        if let user = AppDelegate.user {
            userNameField.text = user.USER_NAME
            userTypeField.text = user.USER_TYPE
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 跳转到回瓶管理
    @IBAction func bottle(_ sender: UIButton) {
        self.navigationController?.pushViewController(BottleListViewController(nibName: "BottleListViewController", bundle: nil), animated: true)
    }
    
    // 跳转到关于界面
    @IBAction func about(_ sender: UIButton) {
        self.navigationController?.pushViewController(AboutViewController(nibName: "AboutViewController", bundle: nil), animated: true)
    }

    // 切换账号
    @IBAction func changeAccount(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
