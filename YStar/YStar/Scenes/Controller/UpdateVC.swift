//
//  UpdateVC.swift
//  wp
//
//  Created by mu on 2017/5/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class UpdateVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.masksToBounds = true
        guard AppDataHelper.instance().updateModel != nil else {
            return
        }
        sureBtn.backgroundColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
        timeLabel.text = "发布时间:\(AppDataHelper.instance().updateModel!.newAppReleaseTime)"
        versionLabel.text = "版本:\(AppDataHelper.instance().updateModel!.newAppVersionName)"
        mLabel.text = "大小:\(AppDataHelper.instance().updateModel!.newAppSize)M"
        contentLabel.attributedText = NSAttributedString.init(string: AppDataHelper.instance().updateModel!.newAppUpdateDesc)
    }

    //确认
    @IBAction func sureBtnTapped(_ sender: Any) {
        guard AppDataHelper.instance().updateModel != nil else {
            return
        }
        if AppDataHelper.instance().updateModel!.isForceUpdate == 0 {
            UIApplication.shared.openURL(URL.init(string: "https://fir.im/starShareAdmin")!)
            return
        }
        dismissController()
    }
}
