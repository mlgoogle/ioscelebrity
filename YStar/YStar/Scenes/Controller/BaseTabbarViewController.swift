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
        
        let storyboardNames = ["Benifity","Fans","Meet","Question"]
        
        let itemIconNames = ["\u{e65e}","\u{e65b}","","\u{e66b}"]
        let titles = ["收益管理","联系粉丝","约见管理","粉丝问答"]
        
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            if index == 2 {
                controller?.tabBarItem.title = titles[2]
                controller?.tabBarItem.image = UIImage(named: "meetManager_normal")
                controller?.tabBarItem.selectedImage = UIImage(named: "meetManager_selected")
                 controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)], for: .selected)
            } else {
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.imageWith(itemIconNames[index], fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: 0x999999)).withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.imageWith(itemIconNames[index], fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)).withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)], for: .selected)
            }
            addChildViewController(controller!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(WYIMLoginSuccess( _ :)), name: Notification.Name(rawValue:AppConst.NoticeKey.WYIMLoginSuccess.rawValue), object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(showUpdateInfo), name: NSNotification.Name(rawValue: AppConst.NoticeKey.checkUpdte.rawValue), object: nil)
    }
    
    func WYIMLoginSuccess(_ IMloginSuccess : NSNotification)  {
        
        print("登陆成功")
        
        NIMSDK.shared().loginManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        NIMSDK.shared().systemNotificationManager.add(self)
        
        self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
        print("未读消息条数====\(self.sessionUnreadCount)")
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
    
    func onKick(_ code: NIMKickReason, clientType: NIMLoginClientType) {
        AppDataHelper.instance().clearUserInfo()
        checkLogin()
    }
    
    deinit {
        
        NIMSDK.shared().loginManager.remove(self)
        NIMSDK.shared().conversationManager.remove(self)
        NIMSDK.shared().systemNotificationManager.remove(self)
        
        NotificationCenter.default.removeObserver(self)
    }
    
}
