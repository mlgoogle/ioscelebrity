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
//        newsIcon.image = UIImage.imageWith(AppConst.iconFontName.newsIcon.rawValue, fontSize: newsIcon.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    
    
    override func update(_ data: Any!) {
        
        if let model = data as? FansListModel {
            
            let placeholderImage = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
            
            self.iconImage.kf.setImage(with: URL(string:qiniuHelper.shared().qiniuHeader +  model.head_url), placeholder: placeholderImage)
            self.nameLabel.text = model.nickname
            self.newsCount.isHidden = model.unreadCount == 0
            newsCount.text = "  \(model.unreadCount)  "
    }
  }
    
}


class FansListVC: BasePageListTableViewController,NIMLoginManagerDelegate,NIMConversationManagerDelegate,NIMSystemNotificationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NIMSDK.shared().loginManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        NIMSDK.shared().systemNotificationManager.add(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WYIMLoginSuccess( _ :)), name: Notification.Name(rawValue:AppConst.NoticeKey.WYIMLoginSuccess.rawValue), object: nil)
    }
    
    deinit {
        
        NIMSDK.shared().loginManager.remove(self)
        NIMSDK.shared().conversationManager.remove(self)
        NIMSDK.shared().systemNotificationManager.remove(self)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        tableView.rowHeight = 60
    }
    
    
    
    func WYIMLoginSuccess(_ IMloginSuccess : NSNotification)  {
        
        // 刷新红点
        self.refreshSessionRedDot()
        didRequest()
    }
    
    func refreshSessionRedDot() {
        
    }

    // 请求刷新数据
    override func didRequest(_ pageIndex: Int) {
        let requestModel = FansListRquestModel()
        requestModel.starPos = (pageIndex - 1) * 10 + 1
        AppAPIHelper.commen().requestFansList(model: requestModel, complete: {[weak self] (response) -> ()? in
            if let objects = response as? [FansListModel] {
                let unreadCountDic = self?.getUnreadDic()
                for info in objects{
                    if let unreadCount = unreadCountDic?[info.faccid]{
                        info.unreadCount = unreadCount
                    }
                }
                self?.didRequestComplete(objects as AnyObject?)
            } else {
                self?.didRequestComplete(nil)
            }
            self?.tableView.reloadData()
            return nil
        }, error: errorBlockFunc())
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fansListModel = self.dataSource?[indexPath.row] as! FansListModel
        
        let session = NIMSession(fansListModel.faccid, type: .P2P)
        let fansSessionVC = FansSessionViewController(session: session)
        fansSessionVC?.fansNickName = fansListModel.nickname
        fansSessionVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(fansSessionVC!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return FansListCell.className()
    }
    
    func getUnreadDic() ->  [String: Int]{
        var sessionIdDic: [String: Int] = [:]
        if let sessions = NIMSDK.shared().conversationManager.allRecentSessions(){
            for session in sessions{
                if let sessionId = session.session?.sessionId{
                    sessionIdDic[sessionId] = session.unreadCount
                }
            }
        }
        return sessionIdDic
    }
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        didRequest(0)
    }

}
