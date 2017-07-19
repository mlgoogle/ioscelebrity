//
//  MeetTypeDetailVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

private let KMeetTypeDetailCellID = "MeetTypeDetailCell"


class MeetTypeDetailVC: BaseListTableViewController {

    
    var items:[MeetTypeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "约见类型管理"
    }
    
    override func didRequest() {
        didRequestComplete(items as AnyObject?)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        model.status = model.status == 0 ? 1 :0
        tableView.reloadRows(at:[indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return MeetTypeDetailCell.className()
    }

    @IBAction func completeButtonAction(_ sender: UIButton) {
        
    }
}
