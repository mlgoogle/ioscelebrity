//
//  ResetPwdVC.swift
//  YStar
//
//  Created by mu on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD


class ResetPwdVC: BaseTableViewController {

    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var vaildCodeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    var codeTime = 60
    var timer: Timer?
    var timeStamp =  ""
    var vToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        closeBtn.setImage(UIImage.imageWith(AppConst.iconFontName.closeIcon.rawValue, fontSize: CGSize.init(width: 33, height: 33), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.label9.rawValue)), for: .normal)
    }
    // 获取验证码
    @IBAction func codeBtnTapped(_ sender: UIButton) {
        if checkTextFieldEmpty([phoneText]) && isTelNumber(num: phoneText.text!) {
            let checkRegisterRequestModel = CheckRegisterRequestModel()
            checkRegisterRequestModel.phone = phoneText.text!
            AppAPIHelper.commen().CheckRegister(model: checkRegisterRequestModel, complete: {[weak self] (checkRegistResult) in
                if let checkRegistResponse = checkRegistResult {
                    if checkRegistResponse["result"] as! Int == 0 {
                        SVProgressHUD.showErrorMessage(ErrorMessage: "该用户未注册!!!", ForDuration: 2.0, completion: nil)
                        self?.vaildCodeBtn.isEnabled = true
                        return nil
                    } else {
                        SVProgressHUD.showProgressMessage(ProgressMessage: "")
                        let sendVerificationCodeRequestModel = SendVerificationCodeRequestModel()
                        sendVerificationCodeRequestModel.phone = (self?.phoneText.text)!
                        AppAPIHelper.commen().SendVerificationCode(model: sendVerificationCodeRequestModel, complete: {[weak self] (result) in
                            SVProgressHUD.dismiss()
                            if let response = result {
                                if response["result"] as! Int == 1 {
                                    self?.timer = Timer.scheduledTimer(timeInterval: 1,target:self!,selector: #selector(self?.updatecodeBtnTitle),userInfo: nil,repeats: true)
                                    self?.timeStamp = String.init(format: "%ld", response["timeStamp"] as!  Int)
                                    self?.vToken = String.init(format: "%@", response["vToken"] as! String)
                                }
                            }
                            return nil
                        }, error: self?.errorBlockFunc())
                    }
                }
                return nil
            }, error: errorBlockFunc())
        }
    }
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            vaildCodeBtn.isEnabled = true
            vaildCodeBtn.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            vaildCodeBtn.backgroundColor = UIColor(hexString: "BCE0DA")
            return
        }
        vaildCodeBtn.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒重新发送"
        vaildCodeBtn.setTitle(title, for: .normal)
        vaildCodeBtn.backgroundColor = UIColor(hexString: "ECECEC")
    }
    // 重置密码
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        if checkTextFieldEmpty([phoneText,codeText,pwdText]){
            let string = AppConst.pwdKey + self.timeStamp + codeText.text! + phoneText.text!
            if string.md5() != self.vToken{
                SVProgressHUD.showErrorMessage(ErrorMessage: "验证码不正确", ForDuration: 0.5, completion:nil)
                return
            }
            let model = ResetPwdReqModel()
            model.phone = phoneText.text!
            model.pwd = pwdText.text!.md5()
            AppAPIHelper.commen().Resetpwd(model: model,  complete: { (result)  in
                if let response = result {
                    if response["result"] as! Int == 1{
                        // 重置成功
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "重置成功", ForDuration: 2.0, completion: {
                            _ =  self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
                return nil
            }, error: errorBlockFunc())
        }
    }
    
    //
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
