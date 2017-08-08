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
    
    // 收益界面传过来的收益信息Model
    var earningModel : EarningInfoModel?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupData()
    }
    
    func setupUI() {
        
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        self.tableView.tableFooterView = UIView()
        // 分割线
        self.tableView.separatorStyle = .none
        
        let backImage = UIImage.imageWith(AppConst.iconFontName.backItem.rawValue, fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: 0xFFFFFF))
        self.backItemButton.setBackgroundImage(backImage, for: .normal)
    }
    
    // MARK: - 获取数据
    func setupData() {
        
        if self.earningModel != nil {
            // 日期
            let stringDate = String.init(format: "%d", (earningModel?.orderdate)!)
            let yearStr = (stringDate as NSString).substring(to: 4)
            let monthStr = (stringDate as NSString).substring(with: NSMakeRange(4, 2))
            let dayStr = (stringDate as NSString).substring(from: 6)
            
            // 标题
            self.titleLabel.text = String.init(format: "%@-%@-%@", yearStr,monthStr,dayStr)
            
            // 收益
            self.earningsLabel.text = String.init(format: "%.2f",(earningModel?.profit)!)
            
            let model = YesterdayAndTodayPriceRequestModel()
            model.orderdate = (earningModel?.orderdate)!
            AppAPIHelper.commen().requestYesterdayAndTodayPrice(model: model, complete: { (response) -> ()? in
                
                if let objects = response as? YesterdayAndTodayPriceModel {
                    
                    self.todayLabel.text = String.init(format:"今开  %.2f",objects.min_price)
                    self.yesterdayLabel.text = String.init(format:"昨收  %.2f",objects.max_price)
                }
                self.tableView.reloadData()
                return nil
            }, error: { (error) -> ()? in
                self.didRequestError(error)
                self.tableView.reloadData()
                return nil
            })
        }
    }
    
    // MARK: - UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 124
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let benifityDetailCell = tableView.dequeueReusableCell(withIdentifier: KBenifityDetailCellID, for: indexPath) as! BenifityDetailCell
        // 选中样式
        benifityDetailCell.selectionStyle = .none

        if self.earningModel != nil {
            
            benifityDetailCell.setBenifityDetail(model: (self.earningModel)!)
        }
        
        return benifityDetailCell
    }
    
    // MARK: - 返回
    @IBAction func backItemAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
