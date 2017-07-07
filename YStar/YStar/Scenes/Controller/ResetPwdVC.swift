//
//  ResetPwdVC.swift
//  YStar
//
//  Created by mu on 2017/7/6.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ResetPwdVC: BaseTableViewController {

    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        
        closeBtn.setImage(UIImage.imageWith(AppConst.iconFontName.closeIcon.rawValue, fontSize: CGSize.init(width: 33, height: 33), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.label9.rawValue)), for: .normal)
    }

    @IBAction func codeBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
