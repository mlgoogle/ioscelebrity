//
//  BankCardVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// MARK: - 银行信息的TableViewCell
class BankInfoCell: OEZTableViewCell {
    
    
    @IBOutlet weak var bankContentView: UIView!
    
    @IBOutlet weak var bankNameLabel: UILabel! // 银行名称
    
    @IBOutlet weak var cardTypeLabel: UILabel! // 卡类型
    
    @IBOutlet weak var cardImageView: UIImageView! // 卡图片
    
    @IBOutlet weak var cardNumLabel: UILabel! // 卡号
    
    // @IBOutlet weak var closeButton: UIButton! // 关闭按钮
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bankContentView.layer.cornerRadius = 5.0
        bankContentView.layer.masksToBounds = true
        
        // closeButton.setImage(UIImage.imageWith(AppConst.iconFontName.closeIcon.rawValue,fontSize: closeButton.frame.size                                               fontColor: UIColor.init(rgbHex: 0xFFFFFF)), for: .normal)
        
        cardImageView.backgroundColor = UIColor.orange
        
    }
    
    override func update(_ data: Any!) {
    
        self.bankNameLabel.text = "工商银行"
        self.cardTypeLabel.text = "储蓄卡"
        self.cardNumLabel.text  = "**** **** **** 1567"
    }
    
    // closeButtonAction
    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        // 代理
        didSelectRowAction(1)
    }
}

// MARK: - 银行信息Controller
class BankCardVC : BaseTableViewController,OEZTableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()

    }
    
    func setupUI() {
        
        self.title = "银行卡"
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - UITableViewDataSource , UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bankInfocell = tableView.dequeueReusableCell(withIdentifier: "BankInfoCellID") as! BankInfoCell
        
        bankInfocell.update("haha")
        
        return bankInfocell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        
        if action == 1 {
            
            print("点击了close按钮")
        }
        
    }

    
}



