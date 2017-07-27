//
//  UIButton+Extension.swift
//  YStar
//
//  Created by MONSTER on 2017/7/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation


extension UIButton {
    
    private struct controlKeys{
        static var acceptEventInterval = "controlInterval"
        static var acceptEventTime = "controlTime"
        
    }
    var controlInterval: TimeInterval{
        get{
            if let interval = objc_getAssociatedObject(self, &controlKeys.acceptEventInterval) as? TimeInterval{
                return interval
            }
            return 1.0
        }
        set{
            objc_setAssociatedObject(self, &controlKeys.acceptEventInterval, newValue as TimeInterval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var controlTime: TimeInterval{
        get{
            if let time = objc_getAssociatedObject(self, &controlKeys.acceptEventTime) as? TimeInterval{
                return time
            }
            return 3.0
        }
        set{
            objc_setAssociatedObject(self, &controlKeys.acceptEventTime, newValue as TimeInterval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open class func initialize() {
        
        let oldMethod = #selector(UIButton.sendAction(_:to:for:))
        
        let newMethod = #selector(UIButton.y_sendAction(_:to:for:))

        yRuntime.exchangeMethodInClass(cls: self, oSel: oldMethod, nSel: newMethod)
        
    }
    
    
    func y_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        
        if self.classForCoder != UIButton.self || ShareModelHelper.instance().voiceSwitch{
            self.y_sendAction(action, to: target, for: event)
            return
        }
        
    
        if NSDate().timeIntervalSince1970 - self.controlTime < self.controlInterval {
            print("onc")
            return
        }
        
        self.controlTime = NSDate().timeIntervalSince1970
        
        y_sendAction(action, to: target, for:event)
        
        
    }
    
    
}
