//
//  ShareModelHelper.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ShareModelHelper: BaseModel {
    static let model = ShareModelHelper()
    class func instance() -> ShareModelHelper{
        return model
    }
    
    // 设置交易密码
    
    var setPayPwd = [String:String]()
    var starCode = ""
    var uid = 0
    var phone  = ""
    var token = ""
    var userBalanceinfo = UserBalance()
    var voiceSwitch = false
    var qiniuHeader = "http://out9d2vy4.bkt.clouddn.com/"
    var userInfo = UserInfo()
    var allowedVideo = false
    
}
