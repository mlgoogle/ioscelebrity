//
//  BaseTabbarViewController.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BaseTabbarViewController: UITabBarController,NIMLoginManagerDelegate,NIMConversationManagerDelegate,NIMSystemNotificationManagerDelegate {

    // 未读消息
    private var sessionUnreadCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboardNames = ["Benifity","Fans","Meet"]
        let itemIconNames = ["\u{e651}","\u{e60e}","\u{e60b}"]
        let titles = ["收益管理","粉丝管理","约见管理"]
        
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.imageWith(itemIconNames[index], fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: 0x999999)).withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.imageWith(itemIconNames[index], fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)).withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)], for: .selected)
            addChildViewController(controller!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(WYIMLoginSuccess( _ :)), name: Notification.Name(rawValue:AppConst.NoticeKey.WYIMLoginSuccess.rawValue), object: nil)
    }
    
    func WYIMLoginSuccess(_ IMloginSuccess : NSNotification)  {
        
        print("登陆成功")
        
        NIMSDK.shared().loginManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        NIMSDK.shared().systemNotificationManager.add(self)
        
        self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
        print("未读消息条数====\(NIMSDK.shared().conversationManager.allUnreadCount())")
        // 刷新红点
        self.refreshSessionRedDot()
    }
    
    // 刷新是否显示红点
    func refreshSessionRedDot() {
        if self.sessionUnreadCount == 0 {
            self.tabBar.hideBadgeOnItemIndex(index: 1)
        } else {
            self.tabBar.showshowBadgeOnItemIndex(index: 1)
        }
    }
    
    func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        self.sessionUnreadCount = totalUnreadCount
        self.refreshSessionRedDot()
    }
    
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        self.sessionUnreadCount = totalUnreadCount
        self.refreshSessionRedDot()
    }
    
    func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        self.sessionUnreadCount = totalUnreadCount;
        self.refreshSessionRedDot()
        
    }
    
    func allMessagesDeleted() {
        self.sessionUnreadCount = 0
        self.refreshSessionRedDot()
    }
    
    deinit {
        
        NIMSDK.shared().loginManager.remove(self)
        NIMSDK.shared().conversationManager.remove(self)
        NIMSDK.shared().systemNotificationManager.remove(self)
        
        NotificationCenter.default.removeObserver(self)
    }
    
}
