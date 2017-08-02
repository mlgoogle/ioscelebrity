//
//  BindBankCardVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

class BindBankCardVC: BaseTableViewController {

    @IBOutlet weak var starNameTextField: UITextField! // 持卡人姓名
    
    @IBOutlet weak var starCardNumTextField: UITextField! // 卡号
    
    @IBOutlet weak var starPhoneNumTextField: UITextField! // 手机号
    
    @IBOutlet weak var verificationCodeTextField: UITextField! // 验证码

    @IBOutlet weak var sendCodeButton: UIButton! // 发送验证码按钮
    
    @IBOutlet weak var bindBankButton: UIButton! // 绑定银行卡按钮
    
    fileprivate var timer : Timer? // 定时器
    
    fileprivate var codeTimer = 60 // 时间区间

    var timeStamp =  "" // 时间戳
    
    var vToken = ""  // token
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        self.title = "绑定银行卡"
        self.tableView.tableFooterView = UIView.init()
    }
}
// MARK: - 按钮相关操作
extension BindBankCardVC {
    
    // 发送验证码Action
    @IBAction func sendCodeAction(_ sender: UIButton) {
        
        if !checkTextFieldEmpty([starNameTextField,starCardNumTextField,starPhoneNumTextField]) {
            return
        }
        if !isTelNumber(num: starPhoneNumTextField.text!) {
            SVProgressHUD.showError(withStatus: "请您输入正确的手机号")
            return
        }
        
        let codeModel = SendVerificationCodeRequestModel()
        codeModel.phone = self.starPhoneNumTextField.text!
        SVProgressHUD.showProgressMessage(ProgressMessage: "")
        
        AppAPIHelper.commen().sendVerificationCode(model: codeModel, complete: {[weak self] (response) -> ()? in
            SVProgressHUD.dismiss()
            self?.sendCodeButton.isEnabled = true
            if let object = response as? verifyCodeModel {
                if object.result == 1 {
                    self?.timer = Timer.scheduledTimer(timeInterval: 1, target: self!, selector: #selector(self?.updateSendCodeButtonTitle), userInfo: nil, repeats: true)
                    self?.timeStamp = object.timeStamp
                    self?.vToken = object.vToken
                }
            }
            return nil
        }) { (error) -> ()? in
            self.didRequestError(error)
            self.sendCodeButton.isEnabled = true
            return nil
        }
    }
    
    // 更新sendCodeButton秒数
    func updateSendCodeButtonTitle() {
        if codeTimer == 0 {
            sendCodeButton.isEnabled = true
            sendCodeButton.setTitle("重新发送", for: .normal)
            codeTimer = 60
            timer?.invalidate()
            sendCodeButton.setTitleColor(UIColor.init(hexString: "FFFFFF"), for: .normal)
            sendCodeButton.backgroundColor = UIColor(hexString: "FB9938")
            return
        }
        sendCodeButton.isEnabled = false
        codeTimer = codeTimer - 1
        let title: String = "\(codeTimer)秒重新发送"
        sendCodeButton.setTitle(title, for: .normal)
        sendCodeButton.setTitleColor(UIColor.init(hexString: "000000"), for: .normal)
        sendCodeButton.backgroundColor = UIColor(hexString: "ECECEC")
    }
    
    // 绑定银行卡Action
    @IBAction func bindBankAction(_ sender: UIButton) {
        
        if !checkTextFieldEmpty([starNameTextField,starCardNumTextField,starPhoneNumTextField,verificationCodeTextField]) {
            return
        }
        
        if !isTelNumber(num: starPhoneNumTextField.text!) {
            SVProgressHUD.showError(withStatus: "请您输入正确的手机号")
            return
        }

        let stringToken = AppConst.pwdKey + self.timeStamp + verificationCodeTextField.text! + starPhoneNumTextField.text!
        if  stringToken.md5() != self.vToken {
            SVProgressHUD.showErrorMessage(ErrorMessage: "验证码错误", ForDuration: 1.0, completion: nil)
            return
        }
        
        let model = BindCardRequestModel()
        model.bankUsername = starNameTextField.text!
        model.account = starCardNumTextField.text!
        AppAPIHelper.commen().bindCard(model: model, complete: {[weak self] (response) -> ()? in
            if let objects = response as? BindBankModel {
                if objects.cardNO.length() != 0 {
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "绑定成功", ForDuration: 2.0, completion: {
                         _ = self?.navigationController?.popViewController(animated: true)
                    })
                } else {
                    SVProgressHUD.showErrorMessage(ErrorMessage: "绑定失败", ForDuration: 2.0, completion: nil)
                }
            }
//            if (response as? BindBankModel) != nil{
//                SVProgressHUD.showSuccessMessage(SuccessMessage: "绑定成功", ForDuration: 2.0, completion: { 
//                    _ = self?.navigationController?.popViewController(animated: true)
//                })
//            }
            return nil
        }, error: errorBlockFunc())
        
    }
    
}
