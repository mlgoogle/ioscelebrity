//
//  BaseTabbarViewController.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BaseTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboardNames = ["Benifity","Fans","Meet"]
        let itemIconNames = ["\u{e645}","\u{e64a}","\u{e630}"]
        let titles = ["收益管理","粉丝管理","约见管理"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.imageWith(itemIconNames[index], fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: 0x999999)).withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.imageWith(itemIconNames[index], fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)).withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)], for: .selected)
            addChildViewController(controller!)
        }
    }
    
}
