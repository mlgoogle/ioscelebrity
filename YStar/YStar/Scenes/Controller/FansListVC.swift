//
//  FansListVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Kingfisher
class FansListCell: OEZTableViewCell{
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newsIcon: UIImageView!
    @IBOutlet weak var newsCount: UILabel!
    
    override func awakeFromNib() {
        newsIcon.image = UIImage.imageWith(AppConst.iconFontName.newsIcon.rawValue, fontSize: newsIcon.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    
    override func update(_ data: Any!) {
        let placeholder = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        iconImage.kf.setImage(with: nil, placeholder: placeholder)
    }
    
}

class FansListVC: BaseListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    override func didRequest() {
        didRequestComplete(["",""] as AnyObject)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 18657195470   -- "15557198601"
        let session = NIMSession("15557198601", type: .P2P)
        
        let fansSessionVC = FansSessionViewController(session: session)
        // vc?.starcode = starInfoModel.starcode
        fansSessionVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(fansSessionVC!, animated: true)
        
    }
    

    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return FansListCell.className()
    }
    
}
