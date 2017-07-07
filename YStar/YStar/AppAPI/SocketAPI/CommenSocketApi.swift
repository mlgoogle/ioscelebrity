//
//  CommenSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class CommenSocketApi: BaseSocketAPI, CommenApi {
    // 登录(模型)
    func login(model: LoginRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .login, model: model)
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
}
