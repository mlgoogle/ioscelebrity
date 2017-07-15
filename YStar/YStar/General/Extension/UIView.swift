//
//  UIView.swift
//  About
//
//  Created by MONSTER on 2017/6/10.
//  Copyright © 2017年 MONSTER. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// X
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    /// Y
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    /// 右边界的x值
    public var rightX: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    /// 下边界的y值
    public var bottomY: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    /// 中心X
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    /// 中心Y
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    /// 宽度
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    /// 高度
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
}
public extension UIView {
    
    var top : CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }
    
    var left : CGFloat {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.y + self.height
        }
        set {
            self.y = newValue - self.height
        }
    }
    
    var right : CGFloat {
        get {
            return self.x + self.width
        }
        set {
            self.x = newValue - self.width
        }
    }
    
//    var centerX : CGFloat {
//        get {
//            return self.center.x
//        }
//        set {
//            self.center = CGPoint(x: newValue, y: self.center.y)
//        }
//    }
    
//    var centerY : CGFloat {
//        get {
//            return self.center.y
//        }
//        set {
//            self.center = CGPoint(x: self.center.x, y: newValue)
//        }
//    }
    
    /// 获取响应链上的UIViewController
    ///
    /// - Returns: UIViewController?
    func viewController_lmy() -> UIViewController?{
        var responder:UIResponder? = self.next
        while responder != nil {
            if (responder?.isKind(of: UIViewController.self)) == true {
                let con = responder as? UIViewController
                return con
            }else {
                responder = responder?.next
            }
        }
        return nil
    }
}
