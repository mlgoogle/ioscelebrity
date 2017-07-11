//
//  MeetOrderDetailVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

private let KMeetOrderDetailCellID = "MeetOrderDetailCell"

class MeetOrderDetailVC: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "约见订单详情"
        
        self.tableView.contentInset = UIEdgeInsetsMake(12, 0, 49, 0)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meetOrderDetailCell = tableView.dequeueReusableCell(withIdentifier: KMeetOrderDetailCellID, for: indexPath) as! MeetOrderDetailCell
        
        return meetOrderDetailCell
    }

}
