//
//  BenifityCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/13.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BenifityCell: UITableViewCell {
    
    
    // 容器View
    @IBOutlet weak var containerView: UIView!
    
    // 成交日期Label
    @IBOutlet weak var dateLabel: UILabel!
    
    // 成交总数Label
    @IBOutlet weak var totalLabel: UILabel!
    
    // 时间总数Label
    @IBOutlet weak var timeLabel: UILabel!
    
    // 订单总金额Label
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 随机颜色测试
        // let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        // let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        // let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        // let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
        
        // self.dateLabel.backgroundColor = colorRun
        // self.totalLabel.backgroundColor = colorRun
        // self.timeLabel.backgroundColor = colorRun
        // self.orderPriceLabel.backgroundColor = colorRun

    }
    
    // FIXME: - 提醒
    func setBenifity() {
        
        self.dateLabel.text = "2017-12-24"
        self.totalLabel.text = "1242"
        self.timeLabel.text = "100021.00"
        self.orderPriceLabel.text = "10002300.00"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
