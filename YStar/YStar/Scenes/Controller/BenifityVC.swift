//
//  BenifityVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

private let KBenifityCellID = "BenifityCell"

class BenifityVC: BaseTableViewController {

    // headerView
    @IBOutlet weak var contentView: UIView!
    // 开始时间按钮
    @IBOutlet weak var beginTimeButton: UIButton!
    // 结束时间按钮
    @IBOutlet weak var endTimeButton: UIButton!
    
    @IBOutlet weak var beginPlaceholderImageView: UIImageView!
    
    @IBOutlet weak var endPlaceholderImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.beginPlaceholderImageView.backgroundColor = UIColor.orange
        self.endPlaceholderImageView.backgroundColor = UIColor.orange
        
        self.tableView.tableHeaderView = contentView
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector(leftButtonClick))
        checkLogin()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        // cell.textLabel?.text = String.init(format: "这个第 %d 行." ,indexPath.row)
        // return cell
        
        let benifityCell = tableView.dequeueReusableCell(withIdentifier: KBenifityCellID, for: indexPath) as! BenifityCell
        
        // TODO: - 待处理数据
        benifityCell.setBenifity()
        
        return benifityCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    func leftButtonClick() {

        let model = BankCardListRequestModel()
        print("====\(model)")
        AppAPIHelper.commen().bankCardList(model: model, complete: {[weak self](response) -> ()? in
            
            if let object = response as? BankListModel {
                if object.cardNo.length() != 0 {
                    let bankCardVC  = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BankCardVC")
                    // 传值
                    (bankCardVC as! BankCardVC).bankCardNO = object.cardNo
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
        AppDataHelper.instance().clearUserInfo()
        checkLogin()
    }
    
    @IBAction func withdrawItemTapped(_ sender: Any) {
        performSegue(withIdentifier: WithdrawalVC.className(), sender: nil)
    }
    
    
}
