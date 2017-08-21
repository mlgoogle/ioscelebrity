//
//  BaseModel.swift
//  viossvc
//
//  Created by yaowang on 2016/11/21.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit
//import XCGLogger
class BaseModel: OEZModel {
    override class func jsonKeyPostfix(_ name: String!) -> String! {
        return "";
    }
    deinit {
        
    }
}



class BaseDBModel: BaseModel {
    var id:Int = 0
    
    
    func primaryKeyValue() ->AnyObject! {
        return id as AnyObject!
    }
    
    class func tableName() ->String {
        return self.className()
    }
    
}


class LoginModle: BaseModel {

    lazy var id  = { () -> Int in
        if let uid = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.uid.rawValue) {
            return uid as! Int
        }
        return 0
    }()
    lazy var token = { () -> String in
        if let token = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.token.rawValue){
            return token as! String
        }
        return ""
    }()

}
class UploadModle: BaseModel {
    
    lazy var uid  = { () -> Int in
        if let uid = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.uid.rawValue) {
            return uid as! Int
        }
        return 0
    }()
    lazy var token = { () -> String in
        if let token = UserDefaults.standard.value(forKey: AppConst.UserDefaultKey.token.rawValue){
            return token as! String
        }
        return ""
    }()
    
}
