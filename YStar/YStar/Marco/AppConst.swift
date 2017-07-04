//
//  AppConfig.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit

typealias CompleteBlock = (AnyObject?) ->()?
typealias ErrorBlock = (NSError) ->()?
typealias paramBlock = (AnyObject?) ->()?
//MARK: --正则表达
func isTelNumber(num: String)->Bool
{
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^1[3|4|5|7|8][0-9]\\d{8}$")
    return predicate.evaluate(with: num)
}


class AppConst {

    
    enum KVOKey: String {
        case selectProduct = "selectProduct"
        case allProduct = "allProduct"
        case currentUserId = "currentUserId"
        case balance = "balance"
    }
    
    enum NoticeKey: String {
        case logoutNotice = "LogoutNotice"
        case updateSoftware = "updateSoftware"
    }
    

   
    
    class Network {
        #if false //是否是开发环境
        static let TcpServerIP:String = "139.224.34.22";
        static let TcpServerPort:UInt16 = 16205
        static let TttpHostUrl:String = "http://139.224.34.22";
        #else
        static let TcpServerIP:String = "i.flight.dlgrme.com";
        static let TcpServerPort:UInt16 = 16205;
        static let HttpHostUrl:String = "http://i.flight.dlgrme.com";
        #endif
        static let TimeoutSec:UInt16 = 10
        static let qiniuHost = "http://ofr5nvpm7.bkt.clouddn.com/"
    }


    enum Action:UInt {
        case callPhone = 10001
        case handleOrder = 11001
    }
    
    enum BundleInfo:String {
        case CFBundleDisplayName = "CFBundleDisplayName"
        case CFBundleShortVersionString = "CFBundleShortVersionString"
        case CFBundleVersion = "CFBundleVersion"
    }	
    
   
  
}
