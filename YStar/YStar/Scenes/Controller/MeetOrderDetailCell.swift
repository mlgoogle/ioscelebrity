//
//  MeetOrderDetailCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetOrderDetailCell: UITableViewCell {

    // 头像
    @IBOutlet weak var iconImageView: UIImageView!
    
    // 名称
    @IBOutlet weak var nameLabel: UILabel!
    
    // 时间
    @IBOutlet weak var timeLabel: UILabel!
    
    // 地点
    @IBOutlet weak var placeLabel: UILabel!
    
    // 约见类型
    @IBOutlet weak var meetTypeLabel: UILabel!

    // 约见备注
    @IBOutlet weak var meetNoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
