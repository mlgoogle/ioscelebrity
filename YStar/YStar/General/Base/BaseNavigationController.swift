//
//  BaseNavigationController.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate ,UIGestureRecognizerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        
        navigationBar.barTintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
        ]
        navigationBar.tintColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK: 重新写左面的导航
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: true)
        
        let btn : UIButton = UIButton.init(type: UIButtonType.custom)
        let backImage = UIImage.imageWith(AppConst.iconFontName.backItem.rawValue, fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: 0x8c0808))
        btn.setTitle("", for: UIControlState.normal)
        btn.setBackgroundImage(backImage, for: UIControlState.normal )
        btn.addTarget(self, action: #selector(popself), for: UIControlEvents.touchUpInside)
        btn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)
        viewController.navigationItem.leftBarButtonItem = barItem
        interactivePopGestureRecognizer?.delegate = self
    }
    func popself(){
        if viewControllers.count > 1 {
            self.popViewController(animated: true)
        }else{
            dismissController()
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (viewControllers.count <= 1)
        {
            return false;
        }
        
        return true;
    }
   
}
