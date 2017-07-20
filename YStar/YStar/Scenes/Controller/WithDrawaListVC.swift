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

    // 提现时间
    @IBOutlet weak var timeLabel: UILabel!
    
    // 银行名称
    @IBOutlet weak var bankNameLabel: UILabel!
    
    // 提现金额
    @IBOutlet weak var moneyLabel: UILabel!
    
    // 刷新cell
    override func update(_ data: Any!) {

        let model : WithdrawModel = data as! WithdrawModel
        
        // let timesp : Int = Date.stringToTimeStamp(stringTime: model.withdrawTime)
        // timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(timesp, format: "yyyy-MM-dd")
        timeLabel.text = model.withdrawTime
        
        let indexTail = model.cardNo.index(model.cardNo.startIndex,  offsetBy: model.cardNo.length()-4)
        let cardNotail = model.cardNo.substring(from: indexTail)
        let bankName : String = model.bank as String
        
        bankNameLabel.text = String.init(format: "%@   尾号(%@)", bankName,cardNotail )
        moneyLabel.text = String.init(format: "- %.2f 元",model.amount)
    }
}


class WithDrawaListVC: BasePageListTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提现记录"
    }
    //  请求接口刷新数据
    override func didRequest(_ pageIndex : Int) {

        let requestModel = WithdrawalListRequetModel()
        requestModel.status = 0
        requestModel.startPos = Int32(pageIndex - 1) * 10 + 1
        
        AppAPIHelper.commen().withDrawList(requestModel: requestModel, complete: { (response) -> ()? in
            if let objects = response as? WithdrawListModel {
                self.didRequestComplete(objects.withdrawList as AnyObject)
            }
            return nil
        }) { (error) -> ()? in
            self.didRequestComplete(nil)
            self.didRequestError(error)
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
