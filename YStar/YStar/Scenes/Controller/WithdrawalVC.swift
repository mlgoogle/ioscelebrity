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
    override func viewDidLoad() {
        super.viewDidLoad()
        inputMoney.delegate = self
        inputMoney.becomeFirstResponder()
        getbankinfo()
        getwealth()
        
    }
    func  getbankinfo(){
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
    
    
    func  getwealth(){
        withDrawMoney.text = "可提现金额" + "¥" + String.init(format: "%.2f", ShareModelHelper.instance().userinfo.balance)
    }

 
    // 全部提现
    @IBAction func withDrawAll(_ sender: Any) {
        inputMoney.text = String.init(format: "%.2f", ShareModelHelper.instance().userinfo.balance)
    }
    // 提现
    @IBAction func withDraw(_ sender: Any) {
        
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
