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

// 收益
class EarningRequestModel : LoginModle {
    var starcode = "1001"
    var stardate : Int64 = 0
    var enddate  : Int64 = 0
}

// 昨收今开
class YesterdayAndTodayPriceRequestModel: LoginModle {
    var starcode = "1001"
    var orderdate : Int64 = 0
}

// 重置支付密码
class ResetPayPwdRequestModel: LoginModle {
    var timestamp : Int64 = 0
    var vCode = ""
    var vToken = ""
    var type = 1
    var pwd = ""
    var phone = ""
}

class CircleListRequestModel: BaseModel {
    
    var pos:Int64 = 0
    var count:Int32 = 10
}
class ApproveCircleModel: BaseModel {
    var star_code = "1001"
    var circle_id:Int64 = 10001
    var uid:Int64 = Int64(ShareModelHelper.instance().uid)
}
class CommentCircleModel: ApproveCircleModel {
    var direction = 0
    var content = "111111111"
    
}
class SendCircleRequestModel: BaseModel {
    var star_code = "1001"
    var content = "d隧道掘进机爱迪生的卡死了；打开了；奥斯卡了；奥斯卡；懒得看洒了；的卡萨；离苦得乐；萨克的；拉斯柯达；拉卡死了；打卡；塑料颗粒；打开了"
    var picurl = "http://p3.img.cctvpic.com/nettv/newgame/2011/0519/20110519071618926.jpg"
}
class DeleteCircle: BaseModel {
    dynamic var star_code = "1001"
    dynamic var circle_id = 0
}
