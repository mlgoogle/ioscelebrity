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
        tokenLogin()
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
    //缓存用户信息
    func cacheUserInfo(object:StarUserModel)  {
        if let uid = object.userinfo?.id{
            ShareModelHelper.instance().uid = Int(uid)
            UserDefaults.standard.set(uid, forKey: AppConst.UserDefaultKey.uid.rawValue)
        }
        if let phone = object.userinfo?.phone{
            ShareModelHelper.instance().phone = phone
            UserDefaults.standard.set(phone, forKey: AppConst.UserDefaultKey.phone.rawValue)
        }
        ShareModelHelper.instance().token = object.token
        ShareModelHelper.instance().starCode = (object.userinfo?.starcode)!
        UserDefaults.standard.set(object.token, forKey: AppConst.UserDefaultKey.token.rawValue)
        UserDefaults.standard.set(object.token_time, forKey: AppConst.UserDefaultKey.tokenTime.rawValue)
    }
    //token登录
    func tokenLogin(){
        if  UserDefaults.standard.object(forKey: AppConst.UserDefaultKey.phone.rawValue) as? String == nil {
            return
        }
        let requestModel = TokenLoginRequestModel()
        AppAPIHelper.commen().tokenLogin(requestModel: requestModel, complete: {[weak self] (result) in
            if let model = result as? StarUserModel {
                self?.cacheUserInfo(object: model)
            }
            return nil
        }) {[weak self] (error ) in
            self?.clearUserInfo()
            return nil
        }
        
    }
}
