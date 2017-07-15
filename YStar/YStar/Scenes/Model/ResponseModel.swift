//
//  ResponseModel.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation
import RealmSwift

class UserInfo: Object {
    dynamic var agentName = ""
    dynamic var avatar_Large = ""
    dynamic var balance = 0.0
    dynamic var id:Int64 = 142
    dynamic var phone = ""
    dynamic var type = 0
}

class StarUserModel: Object {
    dynamic var userinfo  : UserInfo?
    dynamic var result : Int64 = 0
    dynamic var token : String = " "
    dynamic var token_time:Int64 = 0
    dynamic var id:Int64 = 0
    override static func primaryKey() -> String?{
        return "id"
    }
}

class UserBalance: BaseModel {
    var balance: Double = 0
    var is_setpwd = 0
    var nick_name = ""
    var head_url = ""
}

class verifyCodeModel: BaseModel {
    var result : Int64 = 0
    var timeStamp = ""
    var vToken = ""
}

class BankModel: BaseModel {
    
    //返回的列表的key
    var cardList : [BankListModel]?
    
    var cardInfo : [BankInfoModel]?
    
    class func  cardListModelClass() ->AnyClass {
        return  BankListModel.classForCoder()
        
    }
    class func cardInfoModelClass() -> AnyClass {
        return BankInfoModel.classForCoder()
    }
    
    
}

class BankInfoModel: BaseModel {
    
    var bankId: Int64 = 0

    // 银行名称 : "招商银行"
    var bankName:  String = ""
    
    // 卡号: "**** **** **** 2345"
    var cardNO: String = ""
    
    // "招商银行·银联IC普卡"
    var cardName:  String = ""
    
}

//  银行卡返回列表model
class BankListModel: BaseModel {
    
    // bid
    var bid: Int64 = 0
    // bank
    var bank:  String = ""
    // 卡持有人名称
    var bankUsername: String = ""
    // 卡号
    var cardNo: String = ""
    // 卡类型
    var cardName: String = ""
}

class BindBankModel: BaseModel {
    
    //返回的列表的key
    var bid: Int64 = 0
    var cardNO:  String = ""
    var name:  String = ""
    var bankName:  String = ""
    var bankId:  String = ""
}

// 约见类型model
class MeetTypeModel: BaseModel {
    var meetTypeId = ""
    var meetTypeTitle = ""
    var meetTypePrice = ""
    var meetSelect = ""
}

class CircleListModel: Object {
    dynamic var symbol = ""
    dynamic var symbol_name = ""
    dynamic var head_url = ""
    dynamic var circle_id:Int64 = 0
    dynamic var create_time:Int64 = 0
    dynamic var content = ""
    dynamic var pic_url = ""
    let approve_list = List<ApproveModel>()
    let comment_list = List<CircleCommentModel>()
}

class ApproveModel: Object {
    dynamic var user_name = ""
    dynamic var uid:Int64 = 0
}

class CircleCommentModel: Object {
    dynamic var uid = 0
    dynamic var user_name = ""
    dynamic var direction = 0
    dynamic var content = ""
    dynamic var priority = 0
}

class SendCircleResultModel: Object {
    dynamic var circle_id = 0
}

class ResultModel: BaseModel{
    var result = 0
    
}

