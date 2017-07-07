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
        startModelsRequest(packet, modelClass: BankInfoModel.self, complete: complete, error: error)
    }
    
    // MARK: - 绑定银行卡(模型)
    func bindCard(model: BindCardRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .bindCard, model: model)
        startModelRequest(packet, modelClass: BindBankModel.self, complete: complete, error: error)
    }
    
    
}
