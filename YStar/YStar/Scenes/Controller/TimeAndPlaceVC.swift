//
//  TimeAndPlaceVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

private let KoneCellID = "oneCell"
private let KtwoCellID = "twoCell"
private let KthreeCellID = "threeCell"

class TimeAndPlaceVC: BaseTableViewController,DateSelectorViewDelegate {
    
    var placeString : String = "上海市"
    var beginDateString : String = ""
    var endDatrString : String = ""
    
    // 点击时间标识
    var startOrEnd : Bool = true
    
    // MARK: - 初始化
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "时间地址管理"
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    // MARK: - UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KoneCellID, for: indexPath)
            cell.detailTextLabel?.text = placeString 
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KtwoCellID, for: indexPath)
            cell.detailTextLabel?.text = beginDateString
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: KthreeCellID, for: indexPath)
            cell.detailTextLabel?.text = endDatrString
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if  indexPath.row == 0 {
            let choosePlaceVC = ChoosePlaceVC.init(style: .plain)
            choosePlaceVC.placeBlock = { (placeCityStr) in
                self.placeString = placeCityStr
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(choosePlaceVC, animated: true)
        }
        if indexPath.row == 1 {
            let datePickerView = DateSelectorView(delegate: self)
            datePickerView.datePicker.minimumDate = NSDate() as Date
            startOrEnd = true
            datePickerView.showPicker()
        }
        
        if indexPath.row == 2 {
            let datePickerView = DateSelectorView(delegate: self)
            datePickerView.datePicker.minimumDate = NSDate() as Date
            startOrEnd = false
            datePickerView.showPicker()
        }
    }
    
    
    // MARK: - DateSelectorViewDelegate
    func chooseDate(datePickerView: DateSelectorView, date: Date) {
        
        if startOrEnd == true {
            let dateString = date.string_from(formatter: "yyyy-MM-dd")
            self.beginDateString = dateString
            self.tableView.reloadData()
        } else {
            let dateString = date.string_from(formatter: "yyyy-MM-dd")
            self.endDatrString = dateString
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - 确定修改按钮Action
    @IBAction func sureToModifyAction(_ sender: UIButton) {
        
        if self.placeString == "" {
            SVProgressHUD.showErrorMessage(ErrorMessage: "约见城市不允许为空", ForDuration: 2.0, completion: nil)
            return
        }
        if self.beginDateString == "" {
            SVProgressHUD.showErrorMessage(ErrorMessage: "约见起始日期不允许为空", ForDuration: 2.0, completion: nil)
            return
        }
        if self.endDatrString == "" {
            SVProgressHUD.showErrorMessage(ErrorMessage: "约见结束日期不允许为空", ForDuration: 2.0, completion: nil)
            return
        }
        // 比较 约见起始日期 - 约见结束日期
        let beginDate = Date.yt_convertDateStrToDate(self.beginDateString, format: "yyyy-MM-dd")
        let endDate = Date.yt_convertDateStrToDate(self.endDatrString, format: "yyyy-MM-dd")
    
        let result:ComparisonResult = beginDate.compare(endDate)
        if result == ComparisonResult.orderedDescending {
            SVProgressHUD.showErrorMessage(ErrorMessage: "约见结束日期不允许小于约见开始日期", ForDuration: 2.0, completion: nil)
            return
        }
        
        let model = placeAndDateRequestModel()
        model.meet_city = self.placeString
        model.startdate = self.beginDateString
        model.enddate = self.endDatrString
        
        AppAPIHelper.commen().requestPlaceAndDate(model: model, complete: { (response) -> ()? in
            if let objects = response as? ResultModel {
                if objects.result == 1 {
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "修改成功", ForDuration: 2.0, completion: { 
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }
            return nil
        }, error: errorBlockFunc())
        
    }
}
