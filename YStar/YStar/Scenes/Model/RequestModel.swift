//
//  RequestModel.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation

class RequestBaseModel: BaseModel {
    
    // 185
    var id = ShareModelHelper.instance().uid ?? 0
    // f7c0f6a8f222ca81e2f60139578552ae
    var token = ShareModelHelper.instance().token ?? ""
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

