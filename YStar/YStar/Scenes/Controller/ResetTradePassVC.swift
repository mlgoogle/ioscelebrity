//
//  ResetTradePassVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

class ResetTradePassVC: BaseTableViewController,UITextFieldDelegate{

    // 手机号码
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    // 验证码
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    // 发送验证码按钮
    @IBOutlet weak var sendCodeButton: UIButton!
    
    // 密码框
    @IBOutlet weak var firstPwdTextField: UITextField!
    
    // 密码框
    @IBOutlet weak var secondPwdTextField: UITextField!
    
    // 重置密码按钮
    @IBOutlet weak var resetPwdButton: UIButton!
    
    // 定时器
    fileprivate var timer : Timer?
    
    // 时间区间
    fileprivate var codeTimer = 60
    
    // 时间戳
    var timeStamp =  ""
    
    // token
    var vToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        self.title = "重置交易密码"
        
        //监听键盘弹起 来改变输入址
        firstPwdTextField.delegate = self
        secondPwdTextField.delegate = self
        
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: firstPwdTextField)
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: phoneNumTextField)
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: verificationCodeTextField)
        NotificationCenter.default.addObserver(self , selector: #selector(valueChange(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: secondPwdTextField)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: 监听输入址变化
    func valueChange(_ textFiled : Notification){
        if phoneNumTextField.text != "" && verificationCodeTextField.text != "" && firstPwdTextField.text != "" && secondPwdTextField.text != "" {
            
            self.resetPwdButton.isEnabled = true
            self.resetPwdButton.backgroundColor = UIColor.init(hexString: "BCE0DA")
        }else{
            self.resetPwdButton.isEnabled = false
            self.resetPwdButton.backgroundColor = UIColor.init(hexString: "B8B8B8")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if((textField.text?.characters.count)! > 5 && string.characters.count > 0){
            return false
        }
        return true;
    }

    // 发送验证码
    @IBAction func sendCodeAction(_ sender: UIButton) {
        
        if !checkTextFieldEmpty([phoneNumTextField]) {
            return
        }
        if !isTelNumber(num: phoneNumTextField.text!) {
            SVProgressHUD.showError(withStatus: "请您输入正确的手机号")
            return
        }
        let codeModel = SendVerificationCodeRequestModel()
        codeModel.phone = self.phoneNumTextField.text!
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

    // 重置密码
    @IBAction func resetPwdButtonAction(_ sender: UIButton) {
        
        if firstPwdTextField.text != secondPwdTextField.text {
            SVProgressHUD.showErrorMessage(ErrorMessage: "两次密码不一致", ForDuration: 2.0, completion: nil)
            return
        }
        
        let stringToken = AppConst.pwdKey + self.timeStamp + verificationCodeTextField.text! + phoneNumTextField.text!
        if  stringToken.md5() != self.vToken {
            SVProgressHUD.showErrorMessage(ErrorMessage: "验证码错误", ForDuration: 2.0, completion: nil)
            return
        }
        let model = ResetPayPwdRequestModel()
        model.timestamp = Int64(timeStamp)!
        model.vCode = self.verificationCodeTextField.text!
        model.vToken = self.vToken
        model.pwd = (firstPwdTextField.text?.md5())!
        model.phone = self.phoneNumTextField.text!
        
        AppAPIHelper.commen().ResetPayPwd(requestModel: model, complete: { (response) -> ()? in
//            if let objects = response {
//                let dictModel = objects as! [String : AnyObject]
//                if dictModel["status"] as! Int == 0 {
//                    SVProgressHUD.showSuccessMessage(SuccessMessage: "重置成功!", ForDuration: 2.0, completion: nil)
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
            if let objects = response as? ResultModel {
                if objects.result == 0 {
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "重置成功!", ForDuration: 2.0, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            return nil
        }) { (error) -> ()? in
            
            self.didRequestError(error)
            return nil
        }
    }
}
