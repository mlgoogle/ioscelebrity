//
//  FansListVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Kingfisher
class FansListCell: OEZTableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newsIcon: UIImageView!
    @IBOutlet weak var newsCount: UILabel!
    
    override func awakeFromNib() {
        newsIcon.image = UIImage.imageWith(AppConst.iconFontName.newsIcon.rawValue, fontSize: newsIcon.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    
    override func update(_ data: Any!) {

        if let model = data as? FansListModel {
            
            let placeholder = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
            self.iconImage.kf.setImage(with: URL.init(string: model.head_url), placeholder: placeholder)
            
            self.nameLabel.text = model.nickname
    }
  }
    
}


class FansListVC: BaseListTableViewController,NIMLoginManagerDelegate {

    
    deinit {
        
        NIMSDK.shared().loginManager.remove(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NIMSDK.shared().loginManager.add(self)
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        tableView.rowHeight = 60
    }
    
    override func didRequest() {
        let requestModel = FansListRquestModel()
        AppAPIHelper.commen().requestFansList(model: requestModel, complete: {[weak self] (response) -> ()? in
            if let objects = response as? [FansListModel] {
                self?.didRequestComplete(objects as AnyObject?)
            }
            self?.tableView.reloadData()
            return nil
        }, error: errorBlockFunc())

    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 18657195470   -- "15557198601"
        // let session = NIMSession("15557198601", type: .P2P)
        
        // let fansSessionVC = FansSessionViewController(session: session)
        // vc?.starcode = starInfoModel.starcode
        // fansSessionVC?.hidesBottomBarWhenPushed = true
        // self.navigationController?.pushViewController(fansSessionVC!, animated: true)
        
        let fansListModel = self.dataSource?[indexPath.row] as! FansListModel
        let session = NIMSession(fansListModel.faccid, type: .P2P)
        let fansSessionVC = FansSessionViewController(session: session)
        fansSessionVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(fansSessionVC!, animated: true)
        
    }
    

    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return FansListCell.className()
    }
}
