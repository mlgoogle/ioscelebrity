//
//  SetPayPwdVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}



class SetPayPwdVC: BaseTableViewController,UITextFieldDelegate {

    var setPass = false
    
    var showKeyBoard : Bool = false

    var passString : String = ""
    
    // 下一步按钮
    @IBOutlet weak var doSetPwdButton: UIButton!
    
    fileprivate var pwdCircleArr = [UILabel]()
    
    fileprivate var textField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        initUI()
    }

    func setupUI() {
        doSetPwdButton.setTitle(setPass == false ? "下一步" :"确定", for: .normal)
        self.title = setPass == true ? "请确认交易密码" :  "设置交易密码"
        self.doSetPwdButton.backgroundColor = UIColor.gray
    }
    
    func initUI() {
        
        textField = UITextField(frame: CGRect(x: 0,y: 60, width: view.frame.size.width, height: 35))
        textField.delegate = self
        textField.isHidden = true
        textField.keyboardType = UIKeyboardType.numberPad
        view.addSubview(textField!)
        textField.backgroundColor = UIColor.red
        textField.becomeFirstResponder()
        
        
        for i in 0  ..< 6 {
            
            let line:UIView = UIView(frame: CGRect(x: 30 + CGFloat(i) * 10 + (( kScreenWidth - 110) / 6.0) * CGFloat(i),
                                                   y: 120,
                                                   width: ((kScreenWidth - 110) / 6.0) ,
                                                   height: ((kScreenWidth - 110) / 6.0)))
            
            line.backgroundColor = UIColor.clear
            line.alpha = 1
            line.layer.borderWidth = 1
            line.layer.cornerRadius = 3
            line.layer.borderColor = UIColor.gray.cgColor
            view.addSubview(line)
            
            let circleLabel:UILabel =  UILabel(frame: CGRect(x: 0 ,
                                                             y: 0 ,
                                                             width: ((kScreenWidth - 110) / 6.0),
                                                             height: ((kScreenWidth - 110) / 6.0)))
            circleLabel.textAlignment = .center
            circleLabel.text = "﹡"
            circleLabel.font = UIFont.systemFont(ofSize: 17)
            circleLabel.layer.masksToBounds = true
            circleLabel.isHidden = true
            pwdCircleArr.append(circleLabel)
            line.addSubview(circleLabel)
        }
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 150)
        btn.addTarget(self, action: #selector(showKeyBordButtonAction(_:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    // 显示键盘
    @IBAction func showKeyBordButtonAction(_ sender: UIButton) {
        
        if showKeyBoard == true {
            textField.resignFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
        showKeyBoard = !showKeyBoard
    }

    // 下一步按钮
    @IBAction func doSetPwdButtonAction(_ sender: UIButton) {
        
        let phoneNum = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.phone.rawValue) as! String
        
        // 请求接口设置交易密码
        if setPass == true {
            if passString.length() == 6 {
                if ShareModelHelper.instance().setPayPwd["passString"] != passString {
                    SVProgressHUD.showErrorMessage(ErrorMessage: "两次密码输入不一致", ForDuration: 2.0, completion: {})
                    return
                }
            }
            
            let model = ResetPayPwdRequestModel()
            model.phone = phoneNum
            model.pwd = passString.md5()
            model.timestamp = 1
            model.type = 0
            
            AppAPIHelper.commen().ResetPayPwd(requestModel: model, complete: { (response) -> ()? in
                if let objects = response {
                    let dictModel = objects as! [String : AnyObject]
                    if dictModel["status"] as! Int == 0 {
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "设置成功", ForDuration: 2.0, completion:nil)
                        let vcCount = self.navigationController?.viewControllers.count
                        self.navigationController?.popToViewController((self.navigationController?.viewControllers[vcCount! - 3])!, animated: true)
//                        for childVC in (self.navigationController?.viewControllers)! {
//                            if childVC.isKind(of: WithdrawalVC.self) {
//                                let withdrawalVC = childVC as! WithdrawalVC
//                                self.navigationController?.popToViewController(withdrawalVC, animated: true)
//                            } else {
//                                self.navigationController?.popToRootViewController(animated: true)
//                            }
//                        }
                    }
                } else {
                    SVProgressHUD.showErrorMessage(ErrorMessage: "设置失败", ForDuration: 2.0, completion: nil)
                }
                return nil
            }, error: { (error) -> ()? in
                self.didRequestError(error)
                return nil
            })
            
        } else {
            if passString.length() == 6 {
                let setPayPwdVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "SetPayPwdVC") as! SetPayPwdVC
                setPayPwdVC.setPass = true
                ShareModelHelper.instance().setPayPwd["passString"] = passString
                self.navigationController?.pushViewController(setPayPwdVC, animated: true)
            } else {
                SVProgressHUD.showErrorMessage(ErrorMessage: "密码需要6位", ForDuration: 2.0, completion: {})
            }
        }
    }
    
    
    func setCircleShow(_ count:NSInteger) {
        
        for circle in pwdCircleArr {
            let supView = circle.superview
            supView?.layer.borderColor = UIColor.gray.cgColor
            supView?.layer.borderWidth = 1
            circle.isHidden = true;
        }
        
        for i in 0 ..< count {
            pwdCircleArr[i].isHidden = false
            let view = pwdCircleArr[i]
            let supView = view.superview
            supView?.layer.borderColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue).cgColor
            supView?.layer.borderWidth = 2
        }
    }
    
    // Mark: 输入变成点
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.characters.count > 5 && string.characters.count > 0) {
            return false
        }
        
        var password : String
        if string.characters.count <= 0 && textField.text?.length() != 0 {
            
            let index = textField.text?.characters.index((textField.text?.endIndex)!, offsetBy: -1)
            password = textField.text!.substring(to: index!)
        }
        else {
            password = textField.text! + string
            
        }
        passString = ""
        self.doSetPwdButton.backgroundColor = UIColor.gray
        self .setCircleShow(password.characters.count)
        
        if(password.characters.count == 6) {
            passString = password
            self.doSetPwdButton.backgroundColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
            
        }
        return true;
    }

}
