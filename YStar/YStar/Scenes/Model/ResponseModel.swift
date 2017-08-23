//
//  ResponseModel.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation
import RealmSwift
import YYText

class UserInfo: Object {
    dynamic var agentName = ""
    dynamic var avatar_Large = ""
    dynamic var balance = 0.0
    dynamic var id:Int64 = 142
    dynamic var phone = ""
    dynamic var type = 0
    dynamic var starcode = ""
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


// 验证码
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

// 银行卡详细信息
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


class CircleListModel: Object {
    dynamic var symbol = ""
    dynamic var symbol_name = ""
    dynamic var head_url = ""
    dynamic var circle_id:Int64 = 0
    dynamic var create_time:Int64 = 0
    dynamic var content = ""
    dynamic var pic_url = ""
    dynamic var approve_dec_time = 0
    dynamic var comment_dec_time = 0
    let approve_list = List<ApproveModel>()
    let comment_list = List<CircleCommentModel>()
    
    var headerHeight: CGFloat = 0.0
    var thumbUpHeight: CGFloat = 0.0
    var approveName = ""
    
    func caclulateHeight() {
        //计算顶部文案高度
        let contentAttribute = NSMutableAttributedString.init(string: content)
        contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: content.length()))
        let size  = CGSize.init(width: kScreenWidth - 80, height: CGFloat.greatestFiniteMagnitude)
        let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
        headerHeight =  layout!.textBoundingSize.height + 300
        //计算点赞文案高度
        for approve in approve_list{
            approveName += "\(approve.user_name),"
        }
        let approveAttribute = NSMutableAttributedString.init(string: approveName)
        approveAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: approveName.length()))
        let approveSize  = CGSize.init(width: kScreenWidth - 112, height: CGFloat.greatestFiniteMagnitude)
        let approveLayout = YYTextLayout.init(containerSize: approveSize, text: approveAttribute)
        thumbUpHeight = approveLayout!.textBoundingSize.height + 20
        for model in comment_list{
            model.calculateHeight()
            model.symbol_name = symbol_name
        }
        
    }
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
    
    var symbol_name = ""
    var circleHeight: CGFloat = 0
    
    func calculateHeight() {
        //计算顶部文案高度
        var comment = "\(user_name):\(content)"
        if direction == 1{
            comment = "\(symbol_name)回复\(user_name):\(content)"
        }
        if direction == 2{
            comment = "\(user_name)回复\(symbol_name):\(content)"
        }
        let contentAttribute = NSMutableAttributedString.init(string: comment)
        contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: comment.length()))
        let size  = CGSize.init(width: kScreenWidth - 80, height: CGFloat.greatestFiniteMagnitude)
        let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
        circleHeight =  layout!.textBoundingSize.height + 16
    }
}

// 收益
class EarningInfoModel: Object {
    
    dynamic var max_price : Double = 0.0      // 最高价
    dynamic var min_price : Double = 0.0      // 最低价
    dynamic var order_count : Int = 0          // 订单总笔数
    dynamic var order_num : Int = 0             // 订单总时间
    dynamic var orderdate : Int64 =  0      // 日期
    dynamic var price  : Double = 0.0            // 订单总金额
    dynamic var profit : Double = 0.0            // 收益
    dynamic var starcode : String = ""          // 明星id
}

// 今开昨收
class YesterdayAndTodayPriceModel: Object {
    
    dynamic var max_price : Double = 0.0  //  昨收
    dynamic var min_price : Double = 0.0   // 今开
    dynamic var price : Double = 0.0
}


// 粉丝列表 
class FansListModel : Object {
    
    dynamic var starcode : String = ""
    dynamic var faccid : String = ""
    dynamic var head_url : String = ""
    dynamic var nickname : String = ""
    dynamic var ownseconds : Int = 0
    dynamic var appoint : Int = 0
    dynamic var uid  : Int = 0
    dynamic var unreadCount = 0
}


class SendCircleResultModel: Object {
    dynamic var circle_id = 0
}

class ResultModel: BaseModel{
    var result = 0
}

class UploadTokenModel: BaseModel{
    var uptoken = ""
}

class WYIMModel: BaseModel {
    var result_value = ""
    var token_value = ""
}

class MeetTypeModel: BaseModel{
    
    var mid = 0
    var name = ""
    var price = 0.0
    var showpic_url = ""
    var status = 0
}

class MeetOrderModel: BaseModel{
    var appoint_time = ""
    var comment = ""
    var headurl = ""
    var id = 0
    var meet_city = ""
    var meet_type = 0
    var mid = 0
    var name = "0"
    var nickname = ""
    var order_time = ""
    var starcode = ""
    var uid = 0
}

// 提现返回Model
class WithdrawModel: BaseModel {
    
    var wid: Int64 = 0           // 提现订单流水号
    var uid: Int64 = 0           // 用户id
    var amount: Double = 0       // 提现金额
    var charge: Int64 = 0        // 提现手续费
    var withdrawTime : String = ""  // 提现时间
    var handleTime: Int64 = 0    //提现时间
    var bank: String = ""            // 银行名称
    var branchBank: String = ""     //支行名称
    var province: String = ""        // 	省
    var city: String = ""            // 	城市
    var cardNo: String = ""          // 	银行卡号
    var name: String = ""            // 姓名
    var comment: String = ""         //	备注
    var status: Int8 = 0        // 状态	1-处理中，2-成功，3-失败
    var expectTime: String!        // 	省
}
// 提现列表的listmodel
class WithdrawListModel: BaseModel {
    
    var withdrawList : [WithdrawModel]!
    
    class func withdrawListModelClass() ->AnyClass {
        return  WithdrawModel.classForCoder()
    }
}

class UpdateParam: BaseModel{
    var appName = ""
    var newAppSize = 0
    var newAppVersionCode: Double = 0
    var newAppVersionName = ""
    var newAppUpdateDesc = ""
    var newAppReleaseTime = ""
    var newAppUrl = ""
    var isForceUpdate = 0
    var haveUpate = false
}

