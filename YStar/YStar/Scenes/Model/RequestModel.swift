//
//  RequestModel.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation



class LoginRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
    var deviceId = ""
}


class BindCardRequestModel: LoginModle {
    var account = "1001"
    var bankUsername = "1001"
}

class BankCardListRequestModel: LoginModle {
    
}

class BankCardInfoRequestModel : LoginModle {
    
    var cardNo = ""
    
}

class SendVerificationCodeRequestModel: BaseModel {
    var phone = ""
}
