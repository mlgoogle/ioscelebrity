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
    
    @IBOutlet weak var dealImageView: UILabel!
    
    @IBOutlet weak var dealLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
