//
//  LoginNavigationController.swift
//  YStar
//
//  Created by mu on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class LoginNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bg: UIToolbar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        bg.barStyle = .blackTranslucent
        bg.backgroundColor = UIColor.black
        bg.alpha = 0.5
        view.addSubview(bg)
        view.sendSubview(toBack: bg)
        
        if let window = UIApplication.shared.keyWindow  {
            window.backgroundColor = UIColor.blue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
