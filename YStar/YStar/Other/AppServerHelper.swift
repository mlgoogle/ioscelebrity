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

class AppServerHelper: NSObject , WXApiDelegate{
    fileprivate static var helper = AppServerHelper()
    
    class func instance() -> AppServerHelper{
        return helper
    }
    
    func initServer() {
        
        initYunXin()
        
        initUMengAnalytics()
    }

    // MARK: -云信
    func initYunXin() {
        // 1a666f611bc374c3962b16df2a22cb34
//         let configDelegate = NIMSDKConfig.init().delegate
//         NIMSDKConfig.shared().delegate = configDelegate
//         NIMSDKConfig.shared().shouldSyncUnreadCount = true
//         NIMSDKConfig.shared().maxAutoLoginRetryTimes = 10
        
         NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
        
    }
    
    
    // MARK: - 友盟统计
    func initUMengAnalytics() {
        
        // 开启日志
        MobClick.setLogEnabled(true)
        
        // appkey = "595c53077f2c747e0600087a"
        
        UMAnalyticsConfig.sharedInstance().appKey = "595c53077f2c747e0600087a"
        
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        
    }
    
    

}
