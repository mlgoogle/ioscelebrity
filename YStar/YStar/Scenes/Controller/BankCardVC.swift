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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bankContentView.layer.cornerRadius = 5.0
        bankContentView.layer.masksToBounds = true
        
        cardImageView.backgroundColor = UIColor.orange
        
    }
    
    override func update(_ data: Any!) {
        
        if let model = data as? BankInfoModel {
            
            self.bankNameLabel.text = model.bankName
            self.cardTypeLabel.text = model.cardName
            
            let index = model.cardNO.index(model.cardNO.startIndex,  offsetBy: 4)
            let index1 = model.cardNO.index(model.cardNO.startIndex,  offsetBy: model.cardNO.length()-4)
            self.cardNumLabel.text =  model.cardNO.substring(to: index) + "  ****  ****  ****  " + model.cardNO.substring(from: index1)
        }
    }
    
}

// MARK: - 银行信息Controller
class BankCardVC : BaseTableViewController,OEZTableViewDelegate {

    // 接收银行卡号
    var bankCardNO = ""
    
    var dataBankInfoModle : BankInfoModel?
    
    // MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        
        // 获取绑定的银行卡信息
        requestBankInfo()

    }
    
    func setupUI() {
        
        self.title = "我的银行卡"
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - 获取绑定的银行卡信息
    func requestBankInfo() {
        
        let model = BankCardInfoRequestModel()
        model.cardNo = bankCardNO
        
        AppAPIHelper.commen().bankCardInfo(model: model, complete: {[weak self] (response) -> ()? in
            
            if let objects = response as? BankInfoModel {
                
                self?.dataBankInfoModle = objects
                
                self?.tableView.reloadData()
            }
            return nil
        }) { (error) -> ()? in
            
            self.didRequestError(error)
            return nil
        }
    }
    
    // MARK: - UITableViewDataSource , UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bankInfocell = tableView.dequeueReusableCell(withIdentifier: "BankInfoCellID") as! BankInfoCell
        
        bankInfocell.update(self.dataBankInfoModle)
        
        return bankInfocell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
}



