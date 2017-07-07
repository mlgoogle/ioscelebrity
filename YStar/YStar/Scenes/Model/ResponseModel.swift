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


class  BankModel: BaseModel {
    
    //返回的列表的key
    var cardList : [BankListModel]?
    
    class func  cardListModelClass() ->AnyClass {
        return  BankListModel.classForCoder()
    }
}
class UnBindBank: BaseModel {
    
    //返回的列表的key
    var result: Int64 = 0
    
}
class BankInfo: BaseModel {
    
    //返回的列表的key
    var bankId: Int64 = 0
    var bankName:  String = "-"
    var cardNO: String = "-"
    var cardName:  String = "-"
    
}
class BindBank: BaseModel {
    
    //返回的列表的key
    var cardNO:  String = "--"
    var name:  String = "-"
    var bid: Int64 = 0
    var bankName:  String = "-"
    var bankId:  String = "-"
    
}

//  银行卡返回列表model
class BankListModel: BaseModel {
    
    // 银行卡id
    var bid: Int64 = 0
    // 用户id
    //    var account: Int64 = 0
    // 银行名称
    var bank:  String = "--"
    // 支行名称
    var account: String = "--"
    // 银行卡号
    //    var account: String = "cardNo"
    //  开户名
    var bankUsername: String = "--"
    var cardNo: String = "--"
    var cardName: String = "--"
}
