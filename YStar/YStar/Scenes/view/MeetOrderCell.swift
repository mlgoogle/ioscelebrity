//
//  MeetOrderCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetOrderCell: OEZTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    // 约见事件
    @IBOutlet weak var thingLabel: UILabel!
    
    @IBOutlet weak var isSureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    override func update(_ data: Any!) {
        if let model = data as? MeetOrderModel{
            self.iconImageView.kf.setImage(with: URL.init(string: model.headurl), placeholder: UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: CGSize.init(width: 35, height: 35), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)))
            self.nameLabel.text = model.nickname
            self.thingLabel.text = String.init(format: "%@   %@", model.name , model.appoint_time)
            self.isSureLabel.text = model.meet_type == 4 ? " 同意 ":" 未确定 "
            self.isSureLabel.backgroundColor = model.meet_type == 4 ? UIColor.init(hexString: "#FB9938") : UIColor.init(rgbHex: 0x999999)
            isSureLabel.layer.cornerRadius = 3
            isSureLabel.layer.masksToBounds = true

        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
