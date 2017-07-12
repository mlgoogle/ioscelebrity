//
//  MeetTypeDetailCell.swift
//  YStar
//
//  Created by MONSTER on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetTypeDetailCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var meetTypeLabel: UILabel!
    
    @IBOutlet weak var meetTypePriceLabel: UILabel!
    
    @IBOutlet weak var meetTypeImageView: UIImageView!
    
    @IBOutlet weak var meetTypeIsSelectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
