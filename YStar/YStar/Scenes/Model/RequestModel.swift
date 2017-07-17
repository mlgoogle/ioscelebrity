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

class CheckRegisterRequestModel: BaseModel {
    var phone = ""
}

class SendVerificationCodeRequestModel: BaseModel {
    var phone = ""
}

class ResetPwdReqModel: BaseModel{
    var phone = ""
    var pwd = ""
}

class EarningRequestModel : LoginModle {
    var starcode = "1001"
    var stardate : Int64 = 0
    var enddate  : Int64 = 0
}

class YesterdayAndTodayPriceRequestModel: LoginModle {
    var starcode = "1001"
    var orderdate : Int64 = 0
}
