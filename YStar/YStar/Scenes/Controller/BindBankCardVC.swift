//
//  BindBankCardVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BindBankCardVC: BaseTableViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "绑定银行卡"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
