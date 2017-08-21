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


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
// 密码校验
func isPassWord(pwd: String) ->Bool {
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "(^[A-Za-z0-9]{6,20}$)")
    return predicate.evaluate(with: pwd)
}

class AppConst {
    
    static let pwdKey = "yd1742653sd"
    static let imageTokenUrl = "http://122.144.169.219:3378/imageToken"
    	
    enum KVOKey: String {
        case selectProduct = "selectProduct"
        case allProduct = "allProduct"
        case currentUserId = "currentUserId"
        case balance = "balance"
    }
    
    enum NoticeKey: String {
        case logoutNotice = "LogoutNotice"
        case updateSoftware = "updateSoftware"
        case WYIMLoginSuccess = "WYIMLoginSuccess"
        case LoginSuccess = "LoginSuccess"
        case checkUpdte = "checkUpdte"
        case LoginFaild = "LoginFaild"
    }
    
    class Network {
        #if true //是否是开发环境
        static let TcpServerIP:String = "122.144.169.214"
        static let TcpServerPort:UInt16 = 16016
        static let TttpHostUrl:String = "http://139.224.34.22"
        #else
        static let TcpServerIP:String = "tapi.smartdata-x.com"
        static let TcpServerPort:UInt16 = 16016
        static let HttpHostUrl:String = "122.144.169.214"
        #endif
        static let TimeoutSec:UInt16 = 10
        static let qiniuHost = "http://ouim6qew1.bkt.clouddn.com/"
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
    
    enum ColorKey: UInt32 {
        case main = 0x185CA5
        case bgColor = 0xfafafa
        case label6 = 0x666666
        case label3 = 0x333333
        case label9 = 0x999999
        case closeColor = 0xFFFFFF
        case linkColor = 0x75c1e7
    }
    
    enum iconFontName: String {
        case backItem = "\u{e61a}"
        case closeIcon = "\u{e63e}"
        case newsIcon = "\u{e634}"
        case userPlaceHolder = "\u{e63d}"
        case thumpUpIcon = "\u{e624}"
        case addIcon = "\u{e611}"
        case commentIcon = "\u{e635}"
        case thumbIcon = "\u{e62f}"
        case showIcon = "\u{e628}"
        case newsPlaceHolder = "\u{e62a}"
        case downArrow = "\u{e610}"
        case upArrow = "\u{e60f}"
        case dealTotalIcon = "\u{e604}"
        case timeTotalIcon = "\u{e603}"
        case priceTotalIcon = "\u{e601}"
//        case selectIcon = "\u{e623}"
//        case selectIcon = "\u{e65f}"
        case selectIcon = "\u{e660}"
        case notselectIcon = "\u{e65f}"
        
    }
    
    enum UserDefaultKey: String {
        case uid = "uid"
        case phone = "phone"
        case token = "token"
        case tokenTime = "token_time"
        case token_value = "token_value"
    }
  
}
