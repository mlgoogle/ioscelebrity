//
//  AppServerHelper.swift
//  wp
//
//  Created by 木柳 on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Alamofire
import UserNotifications

class AppServerHelper: NSObject , WXApiDelegate, UNUserNotificationCenterDelegate{
    fileprivate static var helper = AppServerHelper()
    
    class func instance() -> AppServerHelper{
        return helper
    }
    
    func initServer() {
        
        initUMengAnalytics()
        setupNIMSDK()
        setupBugout()
        VoicePlayerHelper.shared().initRecorder()
    }

    // MARK: -云信
    func setupNIMSDK() {
        registerRemoteNotification()
        NIMSDKConfig.shared().shouldSyncUnreadCount = true
        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "starShareAdminDev")
    }
    
    // MARK: - 注册用户通知(推送)
    func registerRemoteNotification() {
        /*
         警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
         */
        
        /*
         警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
         以下为演示代码，仅供参考，详细说明请参考苹果开发者文档，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken。
         */
        
        let systemVer = (UIDevice.current.systemVersion as NSString).floatValue;
        if systemVer >= 10.0 {
            if #available(iOS 10.0, *) {
                let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
                center.delegate = self;
                center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted:Bool, error:Error?) -> Void in
                    if (granted) {
                        print("注册通知成功") //点击允许
                    } else {
                        print("注册通知失败") //点击不允许
                    }
                })
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                if #available(iOS 8.0, *) {
                    let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(userSettings)
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            };
        }else if systemVer >= 8.0 {
            if #available(iOS 8.0, *) {
                let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(userSettings)
                
                UIApplication.shared.registerForRemoteNotifications()
            }
        }else {
            if #available(iOS 7.0, *) {
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
            }
        }
    }
    // MARK: - 友盟统计
    func initUMengAnalytics() {
        
        // 开启日志
        MobClick.setLogEnabled(true)
        
        UMAnalyticsConfig.sharedInstance().appKey = "595c53077f2c747e0600087a"
        
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
    }
    
    // MARK: -Bugout
    func setupBugout() {
        
        let config = BugoutConfig.default()
        config?.enabledShakeFeedback = true
        config?.enabledMonitorException = true
        Bugout.init("aebdfa2eada182ab8dc7d44fd02a8c50", channel: "channel", config: config)
    }
    
    

}
