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


class FansListVC: BasePageListTableViewController,NIMLoginManagerDelegate,NIMConversationManagerDelegate,NIMSystemNotificationManagerDelegate {

    
    deinit {
        
        NIMSDK.shared().loginManager.remove(self)
        NIMSDK.shared().conversationManager.remove(self)
        NIMSDK.shared().systemNotificationManager.remove(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NIMSDK.shared().loginManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        NIMSDK.shared().systemNotificationManager.add(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WYIMLoginSuccess( _ :)), name: Notification.Name(rawValue:AppConst.NoticeKey.WYIMLoginSuccess.rawValue), object: nil)
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        tableView.rowHeight = 60
    }
    
    func WYIMLoginSuccess(_ IMloginSuccess : NSNotification)  {
        
        print("登陆成功")
        
        // 刷新红点
        self.refreshSessionRedDot()
    }
    
    func refreshSessionRedDot() {
        
    }
    

    
    func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
        print(" didAdd ++++++ didAdd \(recentSession.unreadCount)")
    }
    
    func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
        print(" didRemove ====== didRemove \(recentSession.unreadCount)")
    }
    
    
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
        print("didUpdate ------ didUpdate \(recentSession.unreadCount) ")
        
    }
    
    override func didRequest(_ pageIndex: Int) {
        let requestModel = FansListRquestModel()
        requestModel.starPos = Int32(pageIndex - 1) * 10 + 1
        AppAPIHelper.commen().requestFansList(model: requestModel, complete: {[weak self] (response) -> ()? in
            if let objects = response as? [FansListModel] {
                self?.didRequestComplete(objects as AnyObject?)
            }else{
                self?.didRequestComplete(nil)
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
        
        
        
        
//        let nimSeesionVc = NIMSessionViewController(session: session)
//        nimSeesionVc?.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(nimSeesionVc!, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return FansListCell.className()
    }
}
