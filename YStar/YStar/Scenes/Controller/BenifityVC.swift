//
//  BenifityVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

private let KBenifityCellID = "BenifityCell"

class BenifityVC: BaseTableViewController,DateSelectorViewDelegate {

    // tableHeaderView
    @IBOutlet weak var contentView: UIView!
    // 折线图
    @IBOutlet weak var lineChatView: UIView!
    // 开始时间按钮
    @IBOutlet weak var beginTimeButton: UIButton!
    // 结束时间按钮
    @IBOutlet weak var endTimeButton: UIButton!
    
    @IBOutlet weak var beginPlaceholderImageView: UIImageView!
    
    @IBOutlet weak var endPlaceholderImageView: UIImageView!
    
    // 标识
    var beginOrEnd : Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.beginPlaceholderImageView.backgroundColor = UIColor.orange
        self.endPlaceholderImageView.backgroundColor = UIColor.orange
        
        self.beginTimeButton.addTarget(self, action: #selector(timeButtonClick(_ :)), for: .touchUpInside)
        self.endTimeButton.addTarget(self, action: #selector(timeButtonClick(_ :)), for: .touchUpInside)
        
        self.tableView.tableHeaderView = contentView
        
        self.tableView.separatorStyle = .none
        
    
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
        
        let benifityDetailVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BenifityDetailVC")
        self.navigationController?.pushViewController(benifityDetailVC, animated: true)
        
    }
    
    func timeButtonClick(_ sender : UIButton) {
        
        if sender == beginTimeButton {
            let datePickerView = DateSelectorView(delegate: self)
            beginOrEnd = true
            datePickerView.showPicker()
        } else {
            let datePickerView = DateSelectorView(delegate: self)
            beginOrEnd = false
            datePickerView.showPicker()
        }
    }
    func chooseDate(datePickerView: DateSelectorView, date: Date) {
        
        let weekTimeInterval : TimeInterval = 24 * 60 * 60 * 7
        let dateString = date.string_from(formatter: "yyyy-MM-dd")
        
        if beginOrEnd == true {
            // 获取7天后的日期
            let afterWeekDate = date.addingTimeInterval(weekTimeInterval)
            let afterWeekStr = afterWeekDate.string_from(formatter: "yyyy-MM-dd")
            
            self.beginTimeButton.setTitle(dateString, for: .normal)
            self.endTimeButton.setTitle(afterWeekStr, for: .normal)
            self.tableView.reloadData()
        } else {
            // 获取7天前的日期
            let beforeWeekDate = date.addingTimeInterval(-weekTimeInterval)
            let beforeWeekStr = beforeWeekDate.string_from(formatter: "yyyy-MM-dd")
            self.endTimeButton.setTitle(dateString, for: .normal)
            self.beginTimeButton.setTitle(beforeWeekStr, for: .normal)
            self.tableView.reloadData()
            
        }
        
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
