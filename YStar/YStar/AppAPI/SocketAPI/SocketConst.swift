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
        case heart = 3019
        case login = 3003
        // 绑定银行卡
        case bindCard = 8005
        // 验证码
        case verifycode = 3011
        
        // 是否绑定银行
        case bankcardList = 8003
        
        // 银行信息
        case bankinfo = 8009
        
    }
    enum type:UInt8 {
        case error  = 0
        case user   = 3
    }
    
    
    
}
