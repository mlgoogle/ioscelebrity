//
//  yRuntime.swift
//  YStar
//
//  Created by MONSTER on 2017/7/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class yRuntime: NSObject {
    
    class func exchangeMethodInClass(cls : AnyClass,oSel: Selector,nSel:Selector) {
        
        let oldMethod = class_getInstanceMethod(cls, oSel)
        let newMethod = class_getInstanceMethod(cls, nSel)
        
        let addMethod = class_addMethod(cls, oSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
    
        if addMethod {
            class_replaceMethod(cls, nSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod))
        } else {
            method_exchangeImplementations(oldMethod, newMethod)
        }

    }
}
