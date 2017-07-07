//
//  BenifityVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BenifityVC: BaseTableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector(leftButtonClick))
        checkLogin()
        
    }

    func leftButtonClick() {
        
        let model = BankCardListRequestModel()
        
        print("====\(model)")
        
        AppAPIHelper.commen().bankCardList(model: model, complete: {[weak self](response) -> ()? in
            
            if let object = response as? BankListModel {
                if object.cardNo.length() != 0 {
                    let bankCardVC  = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BankCardVC")
                    self?.navigationController?.pushViewController(bankCardVC, animated: true)
                } else {
                    // 未绑定银行卡
                    let bindBankCardVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BindBankCardVC")
                    self?.navigationController?.pushViewController(bindBankCardVC, animated: true)
                }
            }
            return nil
        }) { (error) -> ()? in
            
            let bindBankCardVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BindBankCardVC")
            self.navigationController?.pushViewController(bindBankCardVC, animated: true)
            return nil
        }
        
    }
    
    @IBAction func withdrawItemTapped(_ sender: Any) {
        performSegue(withIdentifier: WithdrawalVC.className(), sender: nil)
    }
    
    
}
