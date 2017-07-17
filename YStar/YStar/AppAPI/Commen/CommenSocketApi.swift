//
//  CommenSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class CommenSocketApi: BaseSocketAPI, CommenApi {
    
    // MARK: - 登录(模型)
    func login(model: LoginRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .login, model: model)
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    
    // MARK: - 用户信息(模型)
    func userinfo(model: LoginModle, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .userinfo, model: model)
        startModelRequest(packet, modelClass: UserBalance.self, complete: complete, error: error)
    }
    
    // MARK: - 获取短信验证码(模型)
    func sendVerificationCode(model: SendVerificationCodeRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .verifycode, model: model)
        startModelRequest(packet, modelClass: verifyCodeModel.self, complete: complete, error: error)
    }
    
    // MARK: - 是否绑定银行卡(模型)
    func bankCardList(model: BankCardListRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .bankcardList, model: model)
        startModelRequest(packet, modelClass: BankListModel.self, complete: complete, error: error)
        
    }
    
    // MARK: - 获取银行卡信息(模型)
    func bankCardInfo(model: BankCardInfoRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .bankinfo, model: model)
        startModelRequest(packet, modelClass: BankInfoModel.self, complete: complete, error: error)
    }
    
    // MARK: - 绑定银行卡(模型)
    func bindCard(model: BindCardRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .bindCard, model: model)
        startModelRequest(packet, modelClass: BindBankModel.self, complete: complete, error: error)
    }
    
    // MARK: - 校验用户登录(模型)
    func CheckRegister(model: CheckRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .checkRegist, model: model)
        
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: - 发送验证码(模型)
    func SendVerificationCode(model: SendVerificationCodeRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet:SocketDataPacket = SocketDataPacket.init(opcode: .verifycode, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: - 重置密码(模型)
    func Resetpwd(model: ResetPwdReqModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet:SocketDataPacket = SocketDataPacket.init(opcode: .verifycode, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // 朋友圈
    func requestCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .circleList, model: requestModel)
        startModelsRequest(packet, listKey: "circle_list", modelClass: CircleListModel.self, complete: complete, error: error)
    }
    
    // 评论动态
    func commentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .commentCircle, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // 明星评论
    func starCommentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starComment, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // 点赞动态
    func approveCircle(requestModel:ApproveCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .approveCircle, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // 发送动态
    func sendCircle(requestModel:SendCircleRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .sendCircle, model: requestModel)
        startModelRequest(packet, modelClass: SendCircleResultModel.self, complete: complete, error: error)
    }
    
    // 删除动态
    func deleteCircle(requestModel:DeleteCircle, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .deleteCircle, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // MARK: - 收益列表(模型)
    func requestEarningInfo(model: EarningRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .earningInfo, model: model)
        startModelsRequest(packet, listName: "OrderList", modelClass: EarningInfoModel.self, complete: complete, error: error)
    }
    
    // MARK: - 昨收今开(模型)
    func requestYesterdayAndTodayPrice(model: YesterdayAndTodayPriceRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .yesterdayAndToday, model: model)
        startModelRequest(packet, modelClass: YesterdayAndTodayPriceModel.self, complete: complete, error: error)
    }
}
