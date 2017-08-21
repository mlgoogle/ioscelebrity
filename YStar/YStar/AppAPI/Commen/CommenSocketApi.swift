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
    
    // MARK: -  tokenLogin token登录
    func tokenLogin(requestModel:TokenLoginRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .tokenLogin, model: requestModel)
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
    
    //个人朋友圈
    func requestStarCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starCircle, model: requestModel)
        startModelsRequest(packet, listKey: "circle_list", modelClass: CircleListModel.self, complete: complete, error: error)
    }
    
    // 评论动态/回复
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
    
    // MARK: - 重置支付密码(模型)
    func ResetPayPwd(requestModel:ResetPayPwdRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .restPwd, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)

    }
    // MARK: - 验证支付密码(模型)
    func CheckPayPwd(requestModel: CheckPayPwdModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .paypwd, model: requestModel)
        
        // startRequest(packet, complete: complete, error: error)
        
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
        
    }
    // MARK: - 提现(模型)
    func Withdrawal(requestModel: WithdrawalRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .withdraw, model: requestModel)
        
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
        
    }
    // MARK: - 提现列表(模型)
    func withDrawList(requestModel: WithdrawalListRequetModel, complete: CompleteBlock?, error: ErrorBlock?) {
    
        let packet = SocketDataPacket(opcode: .withdrawlist, model: requestModel)
        startModelRequest(packet, modelClass: WithdrawListModel.self, complete: complete, error: error)
    }
    
    // MARK: - 网易云信(模型)
    func registWYIM(model: RegisterWYIMRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .registWY, model: model)
        startModelRequest(packet, modelClass: WYIMModel.self, complete: complete, error: error)
    }
    
    // MARK: - 所有活动类型
    func allOrderTypes(requestModel: MeetTypesRequest, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .allOrderType, model: requestModel)
        startModelsRequest(packet, listName: "OrderList", modelClass: MeetTypeModel.self, complete: complete, error: error)
    }
    
    // MARK: - 明星拥有活动类型
    func starOrderTypes(requestModel: MeetTypesRequest, complete: CompleteBlock?, error: ErrorBlock?){
        let packet = SocketDataPacket(opcode: .starOrderType, model: requestModel)
        startModelsRequest(packet, listName: "OrderList", modelClass: MeetTypeModel.self, complete: complete, error: error)
    }
    
    // 修改明星拥有的活动类型
    func changeOrderType(requestModel: ChangerMeetTypeRequest, complete: CompleteBlock?, error: ErrorBlock?){
        let packet = SocketDataPacket(opcode: .changeMeetType, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // 约见订单

    func allOrder(requestModel: MeetOrderListRequest, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .allOrders, model: requestModel)
        startModelsRequest(packet, listName: "OrderList", modelClass: MeetOrderModel.self, complete: complete, error: error)
    }
    
    // MARK: - 同意约见
    func agreeOrder(requestModel: AgreeOrderRequest, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .agreeOrder, model: requestModel)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // MARK: - 获取粉丝列表
    func requestFansList(model: FansListRquestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .fansLists, model: model)
        startModelsRequest(packet, listName: "OrderList", modelClass: FansListModel.self, complete: complete, error: error)
        
    }
    
    // 修改约见地点时间限制
    func requestPlaceAndDate(model: placeAndDateRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .placeAndDate, model: model)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    
    // 版本更新提醒
    func update(complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .update, dict: ["ttype": 2 as AnyObject], type: .user)
        startModelRequest(packet, modelClass: UpdateParam.self, complete: complete, error: error)
    }
    
    func uploadimg(complete: CompleteBlock?, error: ErrorBlock?){
        
        let model = UploadModle()
    
        let packet = SocketDataPacket(opcode: .uptoken, model: model)
        startModelRequest(packet, modelClass: UploadTokenModel.self, complete: complete, error: error)
    
    }

}
