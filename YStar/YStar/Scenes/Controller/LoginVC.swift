//
//  LoginVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginVC: BaseTableViewController, UINavigationControllerDelegate {

    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        closeBtn.setImage(UIImage.imageWith(AppConst.iconFontName.closeIcon.rawValue, fontSize: CGSize.init(width: 33, height: 33), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.label9.rawValue)), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //忘记密码
    @IBAction func forgetBtnTapped(_ sender: UIButton) {
        
        if let vc  = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            ResetPwdVC.className()) as? ResetPwdVC{
            navigationController?.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //登录
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if checkTextFieldEmpty([phoneText, pwdText]){
            if !isTelNumber(num: phoneText.text!) {
                SVProgressHUD.showErrorMessage(ErrorMessage: "手机号码格式错误", ForDuration: 2.0, completion: nil)
                return
            }
            if !isPassWord(pwd: pwdText.text!) {
                SVProgressHUD.showErrorMessage(ErrorMessage: "请输入6位字符以上密码", ForDuration: 2.0, completion: nil)
                return
            }
            
            SVProgressHUD.showProgressMessage(ProgressMessage: "登录中...")
            let param = LoginRequestModel()
            param.phone = phoneText.text!
            param.pwd = pwdText.text!.md5()
            AppAPIHelper.commen().login(model: param, complete: { [weak self](result) -> ()? in
                SVProgressHUD.dismiss()
                if let object = result as? StarUserModel{
                    if let uid = object.userinfo?.id{
                        ShareModelHelper.instance().uid = Int(uid)
                        UserDefaults.standard.set(uid, forKey: AppConst.UserDefaultKey.uid.rawValue)
                    }
                    if let phone = object.userinfo?.phone{
                        ShareModelHelper.instance().phone = phone
                        UserDefaults.standard.set(phone, forKey: AppConst.UserDefaultKey.phone.rawValue)
                    }
                    ShareModelHelper.instance().token = object.token
                    self?.dismissController()
                }
                return nil
            }, error: errorBlockFunc())
        }
        
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        dismissController()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop{
            return YPopAnimation()
        }
        if operation == .push{
            return YPushAnimation()
        }
        return nil
    }
}
