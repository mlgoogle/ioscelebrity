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
        
        NIMSDK.shared().register(withAppID: "appkey", cerName: "")
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
