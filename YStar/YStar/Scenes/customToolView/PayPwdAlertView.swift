//
//  PayPwdAlertView.swift
//  YStar
//
//  Created by MONSTER on 2017/7/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// MARK: - 输入支付密码弹窗
class PayPwdAlertView: UIView {

    // 容器
    var contentView:UIView?
    
    var completeBlock : (((String) -> Void)?)
    
    fileprivate var textField:UITextField!
    
    fileprivate var pwdCircleArr = [UILabel]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
