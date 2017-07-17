//
//  BenifityDetailCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/13.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BenifityDetailCell: UITableViewCell {

    
    @IBOutlet weak var timeImageVIew: UIImageView!
    
    @IBOutlet weak var orderPriceImageView: UIImageView!
    
    @IBOutlet weak var dealImageView: UIImageView!
    
    @IBOutlet weak var dealLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    
    func setBenifityDetail(model : EarningInfoModel) {
        
        self.dealLabel.text = String.init(format: "%d", model.order_count)
        self.timeLabel.text = String.init(format: "%d", model.order_num)
        self.orderPriceLabel.text = String.init(format: "%.2f", model.price)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dealImageView.image = UIImage.imageWith(AppConst.iconFontName.dealTotalIcon.rawValue, fontSize: dealImageView.frame.size, fontColor: UIColor.init(rgbHex: 0xFB9938))
        self.timeImageVIew.image = UIImage.imageWith(AppConst.iconFontName.timeTotalIcon.rawValue, fontSize: timeImageVIew.frame.size, fontColor: UIColor.init(rgbHex: 0xFB9938))
        self.orderPriceImageView.image = UIImage.imageWith(AppConst.iconFontName.priceTotalIcon.rawValue, fontSize: orderPriceImageView.frame.size, fontColor: UIColor.init(rgbHex: 0xFB9938))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
