

//
//  AppDataHelper.swift
//  wp
//
//  Created by 木柳 on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AppDataHelper: NSObject {
    fileprivate static var helper = AppDataHelper()
    class func instance() -> AppDataHelper{
        return helper
    }
    
    func initData() {
        
    }
    //检查是否登录
    func checkLogin() -> Bool {
        if let _ = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.uid.rawValue){
            return true
        }
        return false
    }
    //清除用户数据
    func clearUserInfo(){
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultKey.uid.rawValue)
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultKey.phone.rawValue)
    }
}
