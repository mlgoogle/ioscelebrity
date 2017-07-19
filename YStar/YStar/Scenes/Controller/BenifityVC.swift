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
    @IBOutlet weak var lineView: KLineView!
    
    var earningData : [EarningInfoModel]?
    
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
        
        setupUI()
        
        setupInitResponse()
    
        checkLogin()
    }
    
    
    func setupUI() {
        
        self.beginPlaceholderImageView.image = UIImage.imageWith(AppConst.iconFontName.downArrow.rawValue, fontSize: beginPlaceholderImageView.frame.size, fontColor: UIColor.init(rgbHex: 0xDFDFDF))
        self.endPlaceholderImageView.image = UIImage.imageWith(AppConst.iconFontName.downArrow.rawValue, fontSize: beginPlaceholderImageView.frame.size, fontColor: UIColor.init(rgbHex: 0xDFDFDF))
        self.beginTimeButton.addTarget(self, action: #selector(timeButtonClick(_ :)), for: .touchUpInside)
        self.endTimeButton.addTarget(self, action: #selector(timeButtonClick(_ :)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector(leftButtonClick))
        
        self.tableView.tableHeaderView = contentView
        self.tableView.separatorStyle = .none
    }
    
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
        
        // 转换成Int
        let beginDateString = beforeWeekDay.string_from(formatter: "yyyyMMdd")
        let endDateString = beforeDay.string_from(formatter: "yyyyMMdd")
        
        // print("----\(endDateString) ----\(beginDateString)")
        
        var beginDateInt : Int = 0
        if beginDateStr.length() != 0 {
            beginDateInt = Int(beginDateString)!
        }
        var endDateInt : Int = 0
        if endDateString.length() != 0 {
            endDateInt = Int(endDateString)!
        }
        
        let model = EarningRequestModel()
        // model.stardate = Int64(beginDateString)
        // model.enddate = Int64(endDateString)
        
        model.stardate = 20170601
        model.enddate = 20170630
        
        // print("====\(model)")
        
//        AppAPIHelper.commen().requestEarningInfo(model: model, complete: { (response) -> ()? in
//            
//            // print("====\(String(describing: response))")
//            if let objects = response as? [EarningInfoModel] {
//                
//                self.earningData = objects
//                self.lineView.refreshLineChartData(models: objects)
//            }
//            self.tableView.reloadData()
//            return nil
//        }) { (error) -> ()? in
//            
//            self.didRequestError(error)
//            self.tableView.reloadData()
//            print("====\(error)")
//            
//            return nil
//        }
        
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
            
            // 转换成没有分割线
            let beginDateString = date.string_from(formatter: "yyyyMMdd")
            let endDateString = afterWeekDate.string_from(formatter: "yyyyMMdd")
            
            let model = EarningRequestModel()
            model.stardate = Int64(beginDateString)!
            model.enddate = Int64(endDateString)!
            
            //            AppAPIHelper.commen().requestEarningInfo(model: model, complete: { (response) -> ()? in
            //
            //                self.earningData?.removeAll()
            //
            //                if let objects = response as? [EarningInfoModel] {
            //                    self.earningData = objects
            //                }
            //                self.tableView.reloadData()
            //                return nil
            //            }, error: { (error) -> ()? in
            //                self.tableView.reloadData()
            //                self.didRequestError(error)
            //                return nil
            //            })
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
            //            AppAPIHelper.commen().requestEarningInfo(model: model, complete: { (response) -> ()? in
            //
            //                self.earningData?.removeAll()
            //                if let objects = response as? [EarningInfoModel] {
            //                    self.earningData = objects
            //                }
            //                self.tableView.reloadData()
            //                return nil
            //            }, error: { (error) -> ()? in
            //                self.tableView.reloadData()
            //                self.didRequestError(error)
            //                return nil
            //            })
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
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        // cell.textLabel?.text = String.init(format: "这个第 %d 行." ,indexPath.row)
        // return cell
        
        let benifityCell = tableView.dequeueReusableCell(withIdentifier: KBenifityCellID, for: indexPath) as! BenifityCell
       
        // TODO: - 待处理数据
        if earningData != nil {
            
            benifityCell.setBenifity(model: earningData![indexPath.row])
        }
//        benifityCell.setBenifity()
        benifityCell.containerView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.clear : UIColor.white
        
        return benifityCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let benifityDetailVC = UIStoryboard.init(name: "Benifity", bundle: nil).instantiateViewController(withIdentifier: "BenifityDetailVC") as! BenifityDetailVC
        benifityDetailVC.earningModel = self.earningData?[indexPath.row]
        self.navigationController?.pushViewController(benifityDetailVC, animated: true)
        
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
