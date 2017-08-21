//
//  MeetTypeDetailCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetTypeDetailCell: OEZTableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var meetTypeLabel: UILabel!
    
    @IBOutlet weak var meetTypePriceLabel: UILabel!
    
    @IBOutlet weak var meetTypeImageView: UIImageView!
    
    @IBOutlet weak var meetTypeIsSelectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    override func update(_ data: Any!) {
        if let model = data as? MeetTypeModel{
            meetTypeImageView.kf.setImage(with: URL(string:qiniuHelper.shared().qiniuHeader +  model.showpic_url), placeholder: UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: CGSize.init(width: 35, height: 35), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)))
            meetTypeLabel.text = model.name
            meetTypePriceLabel.text = "时间消耗：\(model.price)秒"
            let colorKey = model.status == 0 ? UIColor.init(rgbHex: 0x999999)  : UIColor.init(rgbHex: 0xfb9938)
//            meetTypeIsSelectedImageView.image = UIImage.imageWith(AppConst.iconFontName.selectIcon.rawValue, fontSize: CGSize.init(width: 18, height: 18), fontColor: colorKey)
            meetTypeIsSelectedImageView.image = model.status == 0 ? UIImage.imageWith(AppConst.iconFontName.notselectIcon.rawValue, fontSize: CGSize.init(width: 18, height: 18), fontColor: colorKey) : UIImage.imageWith(AppConst.iconFontName.selectIcon.rawValue, fontSize: CGSize.init(width: 18, height: 18), fontColor: colorKey)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
