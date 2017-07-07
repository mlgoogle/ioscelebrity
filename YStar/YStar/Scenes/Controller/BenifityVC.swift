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
        let bindBankCardVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BindBankCardVC")
        self.navigationController?.pushViewController(bindBankCardVC, animated: true)
    }
    
    @IBAction func withdrawItemTapped(_ sender: Any) {
        performSegue(withIdentifier: WithdrawalVC.className(), sender: nil)
    }
    
    
}
