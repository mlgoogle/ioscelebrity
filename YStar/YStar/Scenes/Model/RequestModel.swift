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
    var isp = ""
    var area = ""
    var isp_id = 0
    var area_id = 0
}

class TokenLoginRequestModel: LoginModle {
    var token_time = { () -> Int in
        if let tokenTime = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.tokenTime.rawValue) {
            return tokenTime as! Int
        }
        return 0
    }()
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

// MARK: - 收益
class EarningRequestModel : LoginModle {
    var starcode = ShareModelHelper.instance().starCode
    var stardate : Int64 = 0
    var enddate  : Int64 = 0
}

// 昨收今开
class YesterdayAndTodayPriceRequestModel: LoginModle {
    var starcode = ShareModelHelper.instance().starCode
    var orderdate : Int64 = 0
}

// 重置交易密码
// type  = 1 重置密码,  type = 0 设置密码
class ResetPayPwdRequestModel: LoginModle {
    var timestamp : Int64 = 0
    var vCode = ""
    var vToken = ""
    var type = 1
    var pwd = ""
    var phone = ""
}

// 绑定银行卡
class BindCardRequestModel: LoginModle {
    var account = ""
    var bankUsername = ""
    var prov = ""
    var city = ""
}

class BankCardListRequestModel: LoginModle {
    
}

// 银行卡信息
class BankCardInfoRequestModel : LoginModle {
    var cardNo = ""
}

// 验证交易密码
class CheckPayPwdModel: LoginModle {
    var uid:Int64 = Int64(ShareModelHelper.instance().uid)
    var paypwd = ""
}

// 提现
class WithdrawalRequestModel: LoginModle {
    var price = 0.0
}

// 提现记录
class WithdrawalListRequetModel: LoginModle {
    var status:Int32 = 0
    var startPos:Int32 = 0
    var count:Int32 = 10
    var time = ""
}

// 粉丝列表
class FansListRquestModel : LoginModle {
    var starcode = ShareModelHelper.instance().starCode
    var starPos = 0
    var count = 10
}

class RegisterWYIMRequestModel: LoginModle {
    var name_value = ""
    var user_type = 0
    var uid  = 0
    var phone = ""
    var memberId = 0
    var agentId = ""
    var recommend = ""
    var timeStamp = 0
}

//MARK: - Circle
class CircleListRequestModel: BaseModel {
    var star_code = ShareModelHelper.instance().starCode
    var pos:Int64 = 0
    var count:Int32 = 10
}

class ApproveCircleModel: BaseModel {
    var star_code = ShareModelHelper.instance().starCode
    var circle_id:Int64 = 0
    var uid:Int64 = Int64(ShareModelHelper.instance().uid)
}

class CommentCircleModel: ApproveCircleModel {
    var direction = 0
    var content = ""
}

class SendCircleRequestModel: BaseModel {
    var star_code = ShareModelHelper.instance().starCode
    var content = ""
    var picurl = ""
}

class DeleteCircle: BaseModel {
    dynamic var star_code = ""
    dynamic var circle_id = 0
}

//MARK: - Meet
class MeetTypesRequest: LoginModle{
    var starcode = ShareModelHelper.instance().starCode
}

class MeetOrderListRequest: LoginModle{
    var starcode = ShareModelHelper.instance().starCode
    var starPos = 0
    var count = 10
}

class AgreeOrderRequest: MeetOrderListRequest{
    var meettype = 4
    var meetid = 0
}

class ChangerMeetTypeRequest: MeetOrderListRequest{
    var mid = 0
    var type = 0
}

class placeAndDateRequestModel: LoginModle {
    var starcode = ShareModelHelper.instance().starCode
    var meet_city = ""
    var startdate = ""
    var enddate = ""
}


class AnswerRequestModel: LoginModle{
    var pType = 0
    var sanswer = ""
    var thumbnailS = ""
}

class QuestionsRequestModel: LoginModle{
    var starcode = ShareModelHelper.instance().starCode
    var pos = 0
    var count = 0
    var aType = 0 // 0文字 1视频 2 语音
    var pType = 2 // 0私有 1公开 2 所有
    var uid = 0
}



