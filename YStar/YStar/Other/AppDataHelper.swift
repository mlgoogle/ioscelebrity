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
    
    var updateModel:UpdateParam?
    
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
        if  object.userinfo != nil{
            ShareModelHelper.instance().starCode = (object.userinfo?.starcode)!
        }
        ShareModelHelper.instance().token = object.token
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
                self?.LoginToYunxin()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:AppConst.NoticeKey.LoginSuccess.rawValue), object: nil, userInfo: nil)
            }
            return nil
        }) {[weak self] (error ) in
            self?.clearUserInfo()
            return nil
        }
    }
    
    func LoginToYunxin() {
        
        let uid = UserDefaults.standard.object(forKey: AppConst.UserDefaultKey.uid.rawValue) as! Int
        let phone = UserDefaults.standard.object(forKey: AppConst.UserDefaultKey.phone.rawValue) as! String
        
        let requestModel = RegisterWYIMRequestModel()
        requestModel.name_value = phone
        requestModel.phone = phone
        requestModel.uid = uid
        
        // print("model ===== \(requestModel)")
        
        AppAPIHelper.commen().registWYIM(model: requestModel, complete: { (response) -> ()? in
            
            if let objects = response as? WYIMModel {
                UserDefaults.standard.set(objects.token_value, forKey: AppConst.UserDefaultKey.token_value.rawValue)
                UserDefaults.standard.synchronize()
                
                let phoneNum = UserDefaults.standard.object(forKey: AppConst.UserDefaultKey.phone.rawValue) as! String
                let token_value = objects.token_value
                
                NIMSDK.shared().loginManager.login(phoneNum, token: token_value, completion: { (error) in
                    if error == nil {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:AppConst.NoticeKey.WYIMLoginSuccess.rawValue), object: nil, userInfo: nil)
                    }
                })
            }
            return nil
        },error: nil)
    }
    
    //MARK: - 查询是否有新版本更新
    func updateUpdateInfo() {
        AppAPIHelper.commen().update(complete: { (response) in
            if let model = response as? UpdateParam {
                self.updateModel = model
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NoticeKey.checkUpdte.rawValue), object: nil)
            }
            return nil
        },error: nil)
    }
    
    func checkUpdate() -> Bool {
        let versionCode = Bundle.main.infoDictionary![AppConst.BundleInfo.CFBundleVersion.rawValue] as! String
        if updateModel == nil {
            return false
        }
        if  Double(versionCode) != nil {
            if updateModel!.newAppVersionCode >  Double(versionCode)! {
                return true
            }
        }
        return false
    }
}
