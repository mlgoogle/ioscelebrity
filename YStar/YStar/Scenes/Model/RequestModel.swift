//
//  RequestModel.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation

class RequestBaseModel: BaseModel {
    
//    var id :Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var id = ShareModelHelper.instance().uid ?? 0
    var token =  ""
}


class LoginRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
    var deviceId = ""
}


class BindCardRequestModel: RequestBaseModel {
    var account = "1001"
    var bankUsername = "1001"
}

