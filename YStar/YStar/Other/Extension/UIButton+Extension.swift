//
//  UIButton+Extension.swift
//  YStar
//
//  Created by MONSTER on 2017/7/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation


extension UIButton {
    
    override open class func initialize() {
        
        let oldMethod = #selector(UIButton.sendAction(_:to:for:))
        
        let newMethod = #selector(UIButton.y_sendAction(_:to:for:))

        yRuntime.exchangeMethodInClass(cls: self, oSel: oldMethod, nSel: newMethod)
        
    }
    
    
    func y_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        
        
        print("哈哈哈哈哈哈");
        
        y_sendAction(action, to: target, for: event)
        
    }
    
    
}
