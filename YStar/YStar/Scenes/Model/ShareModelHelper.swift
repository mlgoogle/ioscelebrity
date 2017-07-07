//
//  ShareModelHelper.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ShareModelHelper: BaseModel {
    static let model = ShareModelHelper()
    class func instance() -> ShareModelHelper{
        return model
    }
    var uid = 0
    var phone  = ""
    var token = ""
    
    
}
