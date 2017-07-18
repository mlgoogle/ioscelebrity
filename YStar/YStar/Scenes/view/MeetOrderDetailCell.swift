//
//  MeetOrderDetailCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SnapKit

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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    // FIXME: - 提醒
    func setMeetOrderDetail() {
        
        // 假数据
        self.iconImageView.layer.cornerRadius = iconImageView.width * 0.5
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.backgroundColor = UIColor.orange
        self.nameLabel.text = "田馥甄"
        self.timeLabel.text = "时间：2017年07月12日14:41"
        self.placeLabel.text = "地点：浙江省杭州市西湖区城西银泰"
        self.meetTypeLabel.text = "约见类型：开演唱会"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .left
        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 14.0),
                          NSParagraphStyleAttributeName: paragraphStyle,
                          NSForegroundColorAttributeName:UIColor.init(rgbHex: 0x666666)]
        
        let str = "约见补充：我都寂寞多久了还是没好 感觉全世界都在窃窃嘲笑 我能有多骄傲 不堪一击好不好 一碰到你我就被撂倒 像是沉睡冰山后从容脱逃 你总是有办法轻易做到 一个远远的微笑 就掀起汹涌波涛 又闻到眼泪沸腾的味道 明明你也很爱我 没理由爱不到结果 只要你敢不懦弱 凭什么我们要错过 夜长梦太多 你就不要想起我"
        self.meetNoteLabel.attributedText = NSMutableAttributedString(string: str, attributes: attributes)
        
    }
    
    
    func setupUI() {
        
        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.meetNoteLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
