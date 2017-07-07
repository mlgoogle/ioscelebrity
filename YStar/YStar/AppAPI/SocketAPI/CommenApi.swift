//
//  CommenApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol CommenApi {
    // 登录(模型)
    func login(model: LoginRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 绑定银行卡(模型)
    func bindCard(model:BindCardRequestModel,complete :CompleteBlock?,error:ErrorBlock?)
}

