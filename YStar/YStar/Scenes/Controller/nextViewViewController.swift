//
//  nextViewViewController.swift
//  YStar
//
//  Created by MONSTER on 2017/7/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class nextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let btn = UIButton.init(type: .infoDark)
        btn.setTitle("你好吗", for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 60, height: 30)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    func btnClick() {

        
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
