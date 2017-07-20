//
//  WithdrawalVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class WithdrawalVC: BaseTableViewController,UITextFieldDelegate {
    
    @IBOutlet var withDrawMoney: UILabel!
    //收款账户
    @IBOutlet var account: UILabel!
    
    @IBOutlet var inputMoney: UITextField!
    
    // 0 设置了密码  1 未设置密码
    var needPwd : Int = 2
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        requestUseBalance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputMoney.delegate = self
        inputMoney.becomeFirstResponder()
        
        requestGetBankInfo()
        
        // requestUseBalance()
        
    }
    
    // 获取银行卡信息
    func requestGetBankInfo(){
        let model = BankCardListRequestModel()
        AppAPIHelper.commen().bankCardList(model: model, complete: { [weak self](result) in
            if let model =  result as? BankListModel{
                let dataModel = BankCardInfoRequestModel()
                dataModel.cardNo = model.cardNo
                AppAPIHelper.commen().bankCardInfo(model: dataModel, complete: { [weak self](result) in
                    if let dataBank =  result as? BankInfoModel{
                        let index1 = model.cardNo.index(model.cardNo.startIndex,  offsetBy: model.cardNo.length()-3)
                        self?.account.text = dataBank.bankName + "(" + model.cardNo.substring(from: index1) + ")"
                    }
                    return nil
                }, error:self?.errorBlockFunc())
            }
            return nil
        }, error:errorBlockFunc())
    }
    
    // 获取金额,及是否设置了交易密码
    func requestUseBalance() {
        let model = LoginModle()
        AppAPIHelper.commen().userinfo(model: model, complete: {[weak self] (response) -> ()? in
            
            if let objects = response as? UserBalance {
                self?.withDrawMoney.text = "可提现金额" + "," + "¥" + String.init(format: "%.2f", objects.balance)
                ShareModelHelper.instance().userinfo.balance = objects.balance
                self?.needPwd = objects.is_setpwd
            }
            return nil
        }, error: errorBlockFunc())
        
        // withDrawMoney.text = "可提现金额" + "¥" + String.init(format: "%.2f", ShareModelHelper.instance().userinfo.balance)
    }

 
    // 全部提现
    @IBAction func withDrawAll(_ sender: Any) {
        inputMoney.text = String.init(format: "%.2f", ShareModelHelper.instance().userinfo.balance)
    }
    // 提现
    @IBAction func withDraw(_ sender: Any) {
        
        if inputMoney.text?.length() == 0 {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入提现金额", ForDuration: 1.0, completion: nil)
            return
        }
        
        if inputMoney.text != ""{
            if Double.init(inputMoney.text!)! > ShareModelHelper.instance().userinfo.balance{
                SVProgressHUD.showErrorMessage(ErrorMessage: "最多可提现" + String.init(format: "%.2f", ShareModelHelper.instance().userinfo.balance), ForDuration: 1, completion: nil)
                return
            }
            if Double.init(inputMoney.text!)! <= 0{
                SVProgressHUD.showErrorMessage(ErrorMessage: "提现金额大于0" , ForDuration: 1, completion: nil)
                return
            }
        }
        
        inputMoney.resignFirstResponder()
        
        if self.needPwd == 1 {
             // 未设置支付密码
            let alertVC = AlertViewController()
            alertVC.showAlertVc(imageName: "tangkuang_kaitongzhifu",
                                titleLabelText: "交易密码",
                                subTitleText: "提现需要开通交易密码才能进行操作",
                                completeButtonTitle: "开 通 支 付", action: {[weak alertVC] (completeButton) in
                                    alertVC?.dismissAlertVc()
                                    let setPayPwdVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "SetPayPwdVC")
                                    self.navigationController?.pushViewController(setPayPwdVC, animated: true)
                                    
            })
        } else {
            // 已设置支付密码
            let payPwdAlertView = PayPwdAlertView(frame: self.view.bounds)
            payPwdAlertView.show(self.view)
            payPwdAlertView.completeBlock = ({[weak self](password:String)  -> Void in
                
                let model = CheckPayPwdModel()
                model.uid = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.uid.rawValue) as! Int64
                model.paypwd = password.md5()
                
                // 校验密码
                AppAPIHelper.commen().CheckPayPwd(requestModel: model, complete: { (response) -> ()? in
                    if let objects = response as? ResultModel {
                        // 密码输入成功
                        if objects.result == 1 {
                            // 发起提现
                            let requestModel = WithdrawalRequestModel()
                            requestModel.price = Double.init((self?.inputMoney.text!)!)!
                            AppAPIHelper.commen().Withdrawal(requestModel: requestModel, complete: { (responseObject) -> ()? in
                                if let resultObj = responseObject as? ResultModel {
                                    if resultObj.result == 1 {
                                        SVProgressHUD.showSuccessMessage(SuccessMessage: "提现成功", ForDuration: 1.0, completion: {
                                            self?.navigationController?.popViewController(animated: true)
                                        })
                                    }
                                }
                                return nil
                            }, error: { (error) -> ()? in
                                self?.didRequestError(error)
                                return nil
                            })
                        } else {
                            // 失败
                            SVProgressHUD.showErrorMessage(ErrorMessage: "密码输入错误", ForDuration: 2.0, completion: {
                                payPwdAlertView.close()
                            })
                        }
                    }
                    return nil
                }, error: { (error) -> ()? in
                    self?.didRequestError(error)
                    return nil
                })
            })
        }
    }
    
    // 忘记密码
    @IBAction func forgetPwdAction(_ sender: UIButton) {
        let resetTradePassVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "ResetTradePassVC")
        self.navigationController?.pushViewController(resetTradePassVC, animated: true)
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultStr = textField.text?.replacingCharacters(in: (textField.text?.range(from: range))!, with: string)
        return resultStr!.isMoneyString()
    }
}
