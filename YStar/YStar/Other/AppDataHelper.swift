

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
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultKey.token.rawValue)
    }
    //获取用户信息
    func userBalance(){
        AppAPIHelper.commen().userinfo(model: LoginModle(), complete: { (result) in
            if let userbalance = result as? UserBalance{
                ShareModelHelper.instance().userinfo = userbalance
            }
            return nil
        }, error: nil)
    }
}
