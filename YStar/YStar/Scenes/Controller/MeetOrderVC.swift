//
//  MeetOrderVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit


private let KMeetOrderCellID = "MeetOrderCell"

class MeetOrderVC: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.contentInset = UIEdgeInsetsMake(64 + 40 + 33, 0, 49, 0)
        self.tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meetOrderCell = tableView.dequeueReusableCell(withIdentifier: KMeetOrderCellID, for: indexPath) as! MeetOrderCell
        meetOrderCell.isSureLabel.text = "未确认"
        meetOrderCell.isSureLabel.backgroundColor = UIColor.init(hexString: "#CCCCCC")
        
        return meetOrderCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
        
        let meetOrderDetailVC = UIStoryboard.init(name: "Meet", bundle: nil).instantiateViewController(withIdentifier: "MeetOrderDetailVC")
        self.navigationController?.pushViewController(meetOrderDetailVC, animated: true)
        
    }
}
