//
//  FansSessionViewController.swift
//  YStar
//
//  Created by MONSTER on 2017/7/19.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

class FansSessionViewController: NIMSessionViewController {
    
    var isbool : Bool = false
    var starcode = ""
    var fansNickName = ""
    
    let fansSessionConfig = FansSessionConfig()
    
    override func sessionConfig() -> NIMSessionConfig! {
        
        return fansSessionConfig
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(hexString: "FAFAFA")
        setupNavbar()
    }
    
    func setupNavbar(){

        navigationItem.leftBarButtonItem = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.imageWith("\u{e61a}", fontSize: CGSize.init(width: 22, height: 22), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)), style: .plain, target: self, action: #selector(leftItemTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
        navigationItem.leftItemsSupplementBackButton = false
        titleLabel.text = fansNickName
        titleLabel.textColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
    }
    
    func leftItemTapped() {
        if (navigationController?.viewControllers.count)! > 1 {
            _ = navigationController?.popViewController(animated: true)
        }else{
            dismissController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ShareModelHelper.instance().voiceSwitch = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ShareModelHelper.instance().voiceSwitch = false
    }
}
