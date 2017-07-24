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
        
        initUMengAnalytics()
    }

    // MARK: -云信
    func setupNIMSDK(sdkConfigDelegate:NTESSDKConfigDelegate?) {
        NIMSDKConfig.shared().delegate = sdkConfigDelegate
        NIMSDKConfig.shared().shouldSyncUnreadCount = true
        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)
        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
    }
    
    
    
    // MARK: - 友盟统计
    func initUMengAnalytics() {
        
        // 开启日志
        MobClick.setLogEnabled(true)
        
        UMAnalyticsConfig.sharedInstance().appKey = "595c53077f2c747e0600087a"
        
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        
    }
    
    

}
