//
//  AppTransition.swift
//  YStar
//
//  Created by mu on 2017/7/7.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation


class YPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        //toController
        let toController = transitionContext.viewController(forKey: .to)
        //contentView
        let contentView = transitionContext.containerView
        
        //toView
        let toView = transitionContext.view(forKey: .to)
        toView?.frame = CGRect.init(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5, width: 0, height: 0)
        toView?.alpha = 0
        //add toView to contentView
        contentView.addSubview(toView!)
        //set the transitionAnimate
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: { (animati) in
            toView?.alpha = 1
            toView?.frame = transitionContext.finalFrame(for: toController!)
        }, completion: { (complete) in
            transitionContext.completeTransition(true)
        })
    }
}

class YDissmissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //fromController
        let fromController = transitionContext.viewController(forKey: .from)
        //contentView
        let contentView = transitionContext.containerView
        //fromView
        let fromView = transitionContext.view(forKey: .from)
        //toView
        let toView = transitionContext.view(forKey: .to)
        toView?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        toView?.alpha = 1
        //add toView to contentView
        contentView.addSubview(toView!)
        //set the transitionAnimate
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: { (animati) in
            fromView?.alpha = 0
            fromView?.frame = transitionContext.finalFrame(for: fromController!)
        }, completion: { (complete) in
            transitionContext.completeTransition(true)
        })
    }
}

class YPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //fromView
        let fromView = transitionContext.view(forKey: .from)
        //contentView
        let contentView = transitionContext.containerView
        //toView
        let toView = transitionContext.view(forKey: .to)
        toView?.frame = CGRect.init(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //add toView to contentView
        contentView.addSubview(toView!)
        //set the transitionAnimate
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: { (animati) in
            fromView?.frame = CGRect.init(x: -UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            toView?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: { (complete) in
            transitionContext.completeTransition(true)
        })
    }
}

class YPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //fromView
        let fromView = transitionContext.view(forKey: .from)
        //contentView
        let contentView = transitionContext.containerView
        //toView
        let toView = transitionContext.view(forKey: .to)
        toView?.frame = CGRect.init(x: -UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //add toView to contentView
        contentView.addSubview(toView!)
        //set the transitionAnimate
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: { (animati) in
            fromView?.frame = CGRect.init(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            toView?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: { (complete) in
            transitionContext.completeTransition(true)
            fromView?.removeFromSuperview()
        })
    }
}
