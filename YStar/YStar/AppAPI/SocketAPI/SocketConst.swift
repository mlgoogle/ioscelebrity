//
//  SockOpcode.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

class SocketConst: NSObject {
    
    enum OPCode:UInt16 {
        // 心跳包
        case heart = 1000
        // 获取图片上传token
        case imageToken = 1047
        // 错误码
        case errorCode = 0
        // 登录
        case login = 3003
        // 绑定银行卡
        case bindCard = 8005
        // 验证码
        case verifycode = 3011
        
        // 是否绑定银行
        case bankcardList = 8003
        // 银行信息
        case bankinfo = 8009
        // 注册
        case register = 3001
        // 注册
        case reducetime = 9017
        //减少时间
        case getlist = 6013
        // 重设密码
        case repwd = 3019
        // 声音验证码
        case voiceCode = 1006
        // 设置用户信息
        case userInfo = 10010
        case bindWchat = 3015
        //设置账号信息
        case WchatLogin = 3013
        case getRealm = 3027
        // 校验用户
        case checkRegist = 3029
        //网易云
        case registWY = 9005
        case userinfo = 3007
        // 修改昵称
        case modifyNickname = 3031
        case paypwd = 7011
        case getorderstars = 10012
        case  tokenLogin  = 3009
        //明星个人信息
        case starInfo = 11005
        //资讯列表
        case newsInfo = 10013
        // banner
        case banners = 10015
        //行情分类
        case marketType = 11001
        //搜索
        case searchStar = 13001
        //搜索
        case weixinpay = 7033
        case alipay = 7049
        //我的资产
        case accountMoney = 1004
        case detailList = 1005
        case creditlist = 6003
        // 重置支付密码
        case restPwd = 3005
        case authentication = 3021
        //分类明星
        case marketStar = 11003
        //添加自选
        case addOptinal = 11015
        case realName = 7045
        //评论列表
        case commetList = 10017
        //明星经历
        case starExperience = 11009
        //明星成就
        case starAchive = 11011
        //新闻
        case newsStarInfo = 10001
        // 明星服务类型
        case starServiceType = 10019
        // 订购明星服务
        case buyStarService = 10021
        // 获取已购明星数量
        case buyStarCount = 10023
        //实时报价
        case realTime = 4001
        //分时图
        case timeLine = 4003
        //明星列表
        case starList = 4007
        //发送评论
        case sendComment = 12001
        //评论列表
        case commentList = 12003
        //发起委托
        case buyOrSell = 5001
        //收到匹配成功
        case receiveMatching = 5101
        //获取拍卖时间
        case auctionStatus = 5005
        //确认订单
        case sureOrder = 5007
        //取消订单
        case cancelOrder = 5009
        //双方确认后结果推送
        case orderResult = 5102
        //当天委托
        case todayEntrust = 6001
        //历史委托
        case historyEntrust = 6005
        //当天成交
        case todayOrder = 6007
        //历史交易
        case historyOrder = 6009
        //委托粉丝榜粉丝榜
        case fansList = 6011
        case getalllist = 10029
        //订单粉丝榜
        case orderFansList = 6015
        //持有明星时间
        case positionCount = 10025
        //拍卖买卖占比
        case buySellPercent = 6017
        //获取明星总时间
        case starTotalTime = 10027
        //获取版本更新信息
        case update = 3033
        //更新devicetoken
        case updateDeviceToken = 3035
        //提现
        case withdraw = 7057
        case withdrawlist = 6019
        //单点登录
        case onlyLogin = 3040
        //取消充值
        case cancelRecharge = 7055
        //朋友圈
        case circleList = 15001
        //某个明星的朋友圈
        case starCircle = 15003
        //发布朋友圈
        case sendCircle = 15005
        //删除朋友圈
        case deleteCircle = 15007
        //点赞朋友圈
        case approveCircle = 15009
        //评论朋友圈
        case commentCircle = 15011
        //明星回复评论
        case starComment = 15013
        //收益信息
        case earningInfo = 16001
        //昨收今开
        case yesterdayAndToday = 16003
        //所有活动类型
        case allOrderType = 16007
        //明星拥有的活动类型
        case starOrderType = 16005
        //修改明星拥有的活动
        case changeMeetType = 16011
        //约见订单列表
        case allOrders = 16009
        //同意约见
        case agreeOrder = 16013
        
    }
    
    
    enum type:UInt8 {
        case error  = 0
        case wp     = 1
        case chat   = 2
        case user   = 3
        case time   = 4
        case deal   = 5
        case operate = 6
        case order = 7
        case getlist = 9
        case bank = 8
        case news = 10
        case market = 11
        case comment = 12
        case search = 13
    }
    
    
    
}
