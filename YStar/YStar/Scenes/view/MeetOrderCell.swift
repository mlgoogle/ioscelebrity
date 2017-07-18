//
//  MeetOrderCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetOrderCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    // 约见事件
    @IBOutlet weak var thingLabel: UILabel!
    
    @IBOutlet weak var isSureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // FIXME: - 提醒
    func setMeetOrder() {
        
        // isSureLabel 状态 : 同意:#FB9938 未确认: #CCCCCC
        // 假数据
        self.iconImageView.backgroundColor = UIColor.blue
        self.nameLabel.text = "田馥甄"
        self.thingLabel.text = "开演唱会,2017-07-12"
        self.isSureLabel.text = "同意"
        self.isSureLabel.backgroundColor = UIColor.init(hexString: "#FB9938")
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
