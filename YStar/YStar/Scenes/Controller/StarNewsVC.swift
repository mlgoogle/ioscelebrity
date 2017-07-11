//
//  StarNewsVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class NewsCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var newsPic: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
    override func update(_ data: Any!) {
        let userIcon = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        iconImage.kf.setImage(with: nil, placeholder: userIcon)
        
        let newsPlace = UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: newsPic.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        newsPic.kf.setImage(with: nil, placeholder: newsPlace)
    }
}

class ThumbupCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var thumbupNames: UILabel!
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith(AppConst.iconFontName.thumpUpIcon.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    override func update(_ data: Any!) {
        
    }
}

class CommentCell: OEZTableViewCell {
    @IBOutlet var commentLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
    override func update(_ data: Any!) {
        
    }
}

class StarNewsVC: BasePageListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didRequest(_ pageIndex: Int) {
        didRequestComplete([["","",""],["","","",""]] as AnyObject)
    }
    
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        switch indexPath.row {
        case 0:
            return NewsCell.className()
        case 1:
            return ThumbupCell.className()
        default:
            return CommentCell.className()
        }
    }
    override func isSections() -> Bool {
        return true
    }
}
