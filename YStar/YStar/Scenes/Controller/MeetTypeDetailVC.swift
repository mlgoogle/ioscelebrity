//
//  MeetTypeDetailVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetTypeDetailVC: BaseTableViewController {

    
    var items:[String] = ["1",
                          "2",
                          "3",
                          "4",
                          "5",
                          "6",
                          "7",
                          "8",
                          "9",
                          "10"]
    
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "约见类型管理"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 60
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: .done, target: self, action: #selector(rightBarButtonItemClick(_ :)))
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "detailCellID")
        // Do any additional setup after loading the view.
    }
    
    func rightBarButtonItemClick(_ sender : AnyObject) {
        print("选中项的索引为：", selectedIndexs)
        print("选中项的值为：")
        for index in selectedIndexs {
            print(items[index])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellID", for: indexPath)
        // cell.textLabel?.text = String.init(format: "这个第 %d 行." ,indexPath.row)
        cell.textLabel?.text = self.items[indexPath.row]
        // 判断是否选中（选中单元格尾部打勾）
        if selectedIndexs.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //判断该行原先是否选中
        if let index = selectedIndexs.index(of: indexPath.row){
            selectedIndexs.remove(at: index) //原来选中的取消选中
        }else{
            selectedIndexs.append(indexPath.row) //原来没选中的就选中
        }
        ////刷新该行
        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
    }

}
