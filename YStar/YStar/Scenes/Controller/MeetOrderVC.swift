//
//  MeetOrderVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetOrderVC: BaseListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        didRequest()
    }
    
    override func didRequest() {
        let param = MeetOrderListRequest()
        AppAPIHelper.commen().allOrder(requestModel: param, complete: { [weak self](result) in
            if let models = result as? [MeetOrderModel]{
                self?.didRequestComplete(models as AnyObject?)
            }
            return nil
        }, error: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return MeetOrderCell.className()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
        if (dataSource?[indexPath.row] as? MeetOrderModel) != nil{
            let model = dataSource?[indexPath.row]
            navigationController?.pushViewController(withIdentifier: MeetOrderDetailVC.className(), completion: { (controller) in
                if let vc = controller as? MeetOrderDetailVC{
                    vc.model = model as! MeetOrderModel
                }
            }, animated: true)
        }
    }
}
