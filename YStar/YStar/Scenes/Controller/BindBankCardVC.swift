//
//  BindBankCardVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BindBankCardVC: BaseTableViewController {

    @IBOutlet weak var starNameTextField: UITextField! // 持卡人姓名
    
    @IBOutlet weak var starCardNumTextField: UITextField! // 卡号
    
    @IBOutlet weak var starPhoneNumTextField: UITextField! // 手机号
    
    @IBOutlet weak var verificationCodeTextField: UITextField! // 验证码

    @IBOutlet weak var sendCodeButton: UIButton! // 发送验证码按钮
    
    @IBOutlet weak var bindBankButton: UIButton! // 绑定银行卡按钮
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "绑定银行卡"
        
    }

    // 发送验证码Action
    @IBAction func sendCodeAction(_ sender: UIButton) {
        
        print("点击了发送验证码");
        
    }
    
    // 绑定银行卡Action
    @IBAction func bindBankAction(_ sender: UIButton) {
    
        print("点击了绑定银行卡")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
