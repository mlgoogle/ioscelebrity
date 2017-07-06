//
//  WithDrawaListVC.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// 定义 WithDrawaListVCCell cell
class WithDrawaListVCCell: OEZTableViewCell {
    
    // 时间lb 
    @IBOutlet weak var minuteLb: UILabel!
    // 时间lb
    @IBOutlet weak var timeLb: UILabel!
    // 银行图片
    @IBOutlet weak var bankLogo: UIImageView!
    // 提现金额
    @IBOutlet weak var moneyLb: UILabel!
    //  提现至
    @IBOutlet weak var withDrawTo: UILabel!
    //  状态
    @IBOutlet weak var statusBtn: UIButton!
    //  状态
    @IBOutlet weak var statusLb: UILabel!
    // 刷新cell
    override func update(_ data: Any!) {

    }
}
class WithDrawaListVC: BasePageListTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提现记录"
    }
    //  请求接口刷新数据
    override func didRequest(_ pageIndex : Int) {

    }
    
}
