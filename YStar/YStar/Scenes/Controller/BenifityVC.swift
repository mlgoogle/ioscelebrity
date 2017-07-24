//
//  BenifityVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Charts

private let KBenifityCellID = "BenifityCell"

class BenifityVC: BaseTableViewController,DateSelectorViewDelegate {

    // tableHeaderView
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var beginTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var beginPlaceholderImageView: UIImageView!
    @IBOutlet weak var endPlaceholderImageView: UIImageView!
    
    // 折线图
    @IBOutlet weak var lineView: KLineView!
    
    // 收益信息
    var earningData : [EarningInfoModel]?
    
    // 点击时间标识
    var beginOrEnd : Bool = true

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        checkLogin()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    
        setupInitResponse()
    }
    
    
    func setupUI() {
        
        self.beginPlaceholderImageView.image = UIImage.imageWith(AppConst.iconFontName.downArrow.rawValue, fontSize: beginPlaceholderImageView.frame.size, fontColor: UIColor.init(rgbHex: 0xDFDFDF))
        self.endPlaceholderImageView.image = UIImage.imageWith(AppConst.iconFontName.downArrow.rawValue, fontSize: beginPlaceholderImageView.frame.size, fontColor: UIColor.init(rgbHex: 0xDFDFDF))
        self.beginTimeButton.addTarget(self, action: #selector(timeButtonClick(_ :)), for: .touchUpInside)
        self.endTimeButton.addTarget(self, action: #selector(timeButtonClick(_ :)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Exit", style: .done, target: self, action: #selector(ExitleftButtonClick))
        
        self.tableView.tableHeaderView = contentView
        self.tableView.separatorStyle = .none
    }
    
    // 默认数据
    func setupInitResponse() {
        
        let cureentDate = NSDate()
        let oneDayTimeInterval : TimeInterval = 24 * 60 * 60 * 1
        let weekDayTimeInterval : TimeInterval = 24 * 60 * 60 * 6
        let beforeDay = cureentDate.addingTimeInterval(-oneDayTimeInterval)
        let beforeWeekDay = beforeDay.addingTimeInterval(-weekDayTimeInterval)
        
        // print("=====现在的日期是\(cureentDate) 一天前的日期====\(beforeDay) ===一周前的日期===\(beforeWeekDay)")
        
        let beginDateStr = beforeWeekDay.string_from(formatter: "yyyy-MM-dd")
        let endDateStr = beforeDay.string_from(formatter: "yyyy-MM-dd")
        
        self.beginTimeButton.setTitle(beginDateStr, for: .normal)
        self.endTimeButton.setTitle(endDateStr, for: .normal)
        
        // 转换成没有分割线
        let beginDateString = beforeWeekDay.string_from(formatter: "yyyyMMdd")
        let endDateString = beforeDay.string_from(formatter: "yyyyMMdd")
        
        // print("----\(endDateString) ----\(beginDateString)")
        
        // 转换成Int
        var beginDateInt : Int64 = 0
        if beginDateStr.length() != 0 {
            beginDateInt = Int64(beginDateString)!
        }
        var endDateInt : Int64 = 0
        if endDateString.length() != 0 {
            endDateInt = Int64(endDateString)!
        }
        
        let model = EarningRequestModel()
        model.stardate = beginDateInt
        model.enddate = endDateInt
        
        requestInitResponse(stardate: model.stardate, enddate: model.enddate)
    
    }
    
    // 点击时间选择
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
        
        let weekTimeInterval : TimeInterval = 24 * 60 * 60 * 6
        let dateString = date.string_from(formatter: "yyyy-MM-dd")
        
        if beginOrEnd == true {
            // 获取7天后的日期
            let afterWeekDate = date.addingTimeInterval(weekTimeInterval)
            let afterWeekStr = afterWeekDate.string_from(formatter: "yyyy-MM-dd")
            self.beginTimeButton.setTitle(dateString, for: .normal)
            self.endTimeButton.setTitle(afterWeekStr, for: .normal)
            
            let beginDateString = date.string_from(formatter: "yyyyMMdd")
            let endDateString = afterWeekDate.string_from(formatter: "yyyyMMdd")
            
            let model = EarningRequestModel()
            model.stardate = Int64(beginDateString)!
            model.enddate = Int64(endDateString)!
            
            requestInitResponse(stardate: model.stardate, enddate: model.enddate)
            
        } else {
            // 获取7天前的日期
            let beforeWeekDate = date.addingTimeInterval(-weekTimeInterval)
            let beforeWeekStr = beforeWeekDate.string_from(formatter: "yyyy-MM-dd")
            self.endTimeButton.setTitle(dateString, for: .normal)
            self.beginTimeButton.setTitle(beforeWeekStr, for: .normal)
            
            let beginDateString = beforeWeekDate.string_from(formatter: "yyyyMMdd")
            let endDateString = date.string_from(formatter: "yyyyMMdd")
            
            let model = EarningRequestModel()
            model.stardate = Int64(beginDateString)!
            model.enddate = Int64(endDateString)!
            
            requestInitResponse(stardate: model.stardate, enddate: model.enddate)
        }
    }
    
    // 请求收益列表信息
    func requestInitResponse(stardate: Int64 , enddate : Int64) {
        
        let requestModel = EarningRequestModel()
        requestModel.stardate = stardate
        requestModel.enddate = enddate
        AppAPIHelper.commen().requestEarningInfo(model: requestModel, complete: { (response) -> ()? in
            if self.earningData != nil {
               self.earningData?.removeAll()
            }
            if let objects = response as? [EarningInfoModel] {
                self.earningData = objects
                self.lineView.refreshLineChartData(models: objects)
            }
            self.tableView.reloadData()
            return nil
        }) { (error) -> ()? in
            self.tableView.reloadData()
            self.didRequestError(error)
            return nil
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return earningData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let benifityCell = tableView.dequeueReusableCell(withIdentifier: KBenifityCellID, for: indexPath) as! BenifityCell
       
        if earningData != nil {
            
            benifityCell.setBenifity(model: earningData![indexPath.row])
        }

        benifityCell.containerView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.clear : UIColor.white
        
        return benifityCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let benifityDetailVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BenifityDetailVC") as! BenifityDetailVC
        benifityDetailVC.earningModel = self.earningData?[indexPath.row]
        self.navigationController?.pushViewController(benifityDetailVC, animated: true)
        
    }
    
    func ExitleftButtonClick() {

         AppDataHelper.instance().clearUserInfo()
        
         checkLogin()
    }
    
    // MARK: - 点击了提现
    @IBAction func rightItemAction(_ sender: UIBarButtonItem) {
        
        if isLogin() {
            let model = BankCardListRequestModel()
            AppAPIHelper.commen().bankCardList(model: model, complete: {[weak self] (response) -> ()? in
                if let objects = response as? BankListModel {
                    if objects.cardNo.length() != 0 {
                        
                        // 已绑定
                        // let bankCardVC  = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BankCardVC") as! BankCardVC
                        // bankCardVC.bankCardNO = objects.cardNo
                        // self?.navigationController?.pushViewController(bankCardVC, animated: true)
                        
                        let withdrawalVC = UIStoryboard.init(name:"Benifity",bundle: nil).instantiateViewController(withIdentifier: "WithdrawalVC") as! WithdrawalVC
                        self?.navigationController?.pushViewController(withdrawalVC, animated: true)
                        
                    } else {
                        // 未绑定
                        let alertVC = AlertViewController()
                        alertVC.showAlertVc(imageName: "tangkuang_kaitongzhifu",
                                            titleLabelText: "绑定银行卡",
                                            subTitleText: "提现操作需先绑定银行卡才能进行操作",
                                            completeButtonTitle: "我 知 道 了",
                                            action: {[weak alertVC] (completeButton) in
                                                alertVC?.dismissAlertVc()
                                                let bindBankCardVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BindBankCardVC")
                                                self?.navigationController?.pushViewController(bindBankCardVC, animated: true)
                        })
                    }
                }
                return nil
                
                }, error: errorBlockFunc())
        }

        }

}
