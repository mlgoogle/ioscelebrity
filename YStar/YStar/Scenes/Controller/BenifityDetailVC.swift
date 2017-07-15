//
//  BenifityDetailVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

private let KBenifityDetailCellID = "BenifityDetailCell"

class BenifityDetailVC: BaseTableViewController {

    // 标题Label
    @IBOutlet weak var titleLabel: UILabel!
    
    // 收益Label
    @IBOutlet weak var earningsLabel: UILabel!
    
    // 今开Label
    @IBOutlet weak var todayLabel: UILabel!
    
    // 昨收Label
    @IBOutlet weak var yesterdayLabel: UILabel!
    
    @IBOutlet weak var backItemButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        self.tableView.tableFooterView = UIView()
        // 分割线
        self.tableView.separatorStyle = .none
        
        let backImage = UIImage.imageWith(AppConst.iconFontName.backItem.rawValue, fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: 0xFFFFFF))
        self.backItemButton.setBackgroundImage(backImage, for: .normal)
        
        // TODO: - 待处理数据
        self.titleLabel.text = "2017-12-23"
        self.earningsLabel.text = "23452.68"
        self.todayLabel.text = "今开  12.88"
        self.yesterdayLabel.text = "昨收  26.58"
    }
    
    @IBAction func backItemAction(_ sender: UIButton) {
        
        print("======= backItemAction =========")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 124
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let benifityDetailCell = tableView.dequeueReusableCell(withIdentifier: KBenifityDetailCellID, for: indexPath) as! BenifityDetailCell
        benifityDetailCell.selectionStyle = .none
        // TODO: - 待处理数据
        
        
        return benifityDetailCell
    }

}
