//
//  PayPwdAlertView.swift
//  YStar
//
//  Created by MONSTER on 2017/7/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


// MARK: - 输入支付密码弹窗
class PayPwdAlertView: UIView,UITextFieldDelegate {

    // 容器
    var contentView:UIView?
    
    var moneyLabel : UILabel!
    
    var completeBlock : (((String) -> Void)?)
    
    fileprivate var textField:UITextField!
    
    fileprivate var pwdCircleArr = [UILabel]()
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView = UIView(frame: CGRect(x: 0,y: self.centerY - 100 ,width: kScreenWidth,height: 240))
        contentView!.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView?.layer.cornerRadius = 3
        self.addSubview(contentView!)
        
        let closeBtn:UIButton = UIButton(type: .custom)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        closeBtn.addTarget(self, action: #selector(PayPwdAlertView.close), for: .touchUpInside)
        closeBtn .setTitle("╳", for: UIControlState())
        closeBtn .setTitleColor(UIColor.black, for: UIControlState())
        contentView!.addSubview(closeBtn)
        
        let titleLabel:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: contentView!.width,height: 46))
        titleLabel.text = "请输入交易密码"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        contentView!.addSubview(titleLabel)
        
        let linView:UIView = UIView (frame: CGRect(x: 0 , y: 46 , width: contentView!.width , height: 1))
        linView.backgroundColor = UIColor.black
        linView.alpha = 0.4
        contentView?.addSubview(linView)
        
//        let moneyLabel:UILabel = UILabel(frame: CGRect(x: 0,y: 56,width: contentView!.width,height: 26))
        // moneyLabel = UILabel(frame: CGRect(x: 0,y: 56,width: contentView!.width,height: 26))
        // moneyLabel.text = "提现金额:  20元"
        // moneyLabel.textAlignment = NSTextAlignment.center
        // moneyLabel.font = UIFont.systemFont(ofSize: 20)
        // contentView?.addSubview(moneyLabel)
        
        textField = UITextField(frame: CGRect(x: 0,y: contentView!.height / 2, width: contentView!.width, height: 35))
        textField.delegate = self
        textField.isHidden = true
        textField.keyboardType = UIKeyboardType.numberPad
        contentView?.addSubview(textField!)
        
        for i in 0  ..< 6 {
            
            let line:UIView = UIView(frame: CGRect(x: 30 + CGFloat(i) * 10 + (( kScreenWidth - 110) / 6.0) * CGFloat(i),
                                                   y: 120,
                                                   width: ((kScreenWidth - 110) / 6.0) ,
                                                   height:  ((kScreenWidth - 110) / 6.0)))
            line.backgroundColor = UIColor.clear
            line.alpha = 1
            line.layer.borderWidth = 1
            line.layer.cornerRadius = 3
            line.layer.borderColor = UIColor.gray.cgColor
            contentView?.addSubview(line)
            
            
            let circleLabel:UILabel =  UILabel(frame: CGRect(x: 0 ,
                                                             y:  0,
                                                             width: ((kScreenWidth - 110) / 6.0),
                                                             height: ((kScreenWidth - 110) / 6.0)))
            
            circleLabel.textAlignment = .center
            circleLabel.text = "﹡"
            circleLabel.font = UIFont.systemFont(ofSize: 17)
            circleLabel.layer.masksToBounds = true
            circleLabel.isHidden = true
            pwdCircleArr.append(circleLabel)
            line.addSubview(circleLabel)
        }
        
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.characters.count > 6) {
            return false
        }
        var password : String
        if string.characters.count <= 0 {
            let index = textField.text?.characters.index((textField.text?.endIndex)!, offsetBy: -1)
            password = textField.text!.substring(to: index!)
        }
        else {
            password = textField.text! + string
        }
        self.setCircleShow(password.characters.count)
        
        if(password.characters.count == 6){
            completeBlock?(password)
            close()
        }
        return true;
    }
    
    func setCircleShow(_ count:NSInteger){
        for circle in pwdCircleArr {
            circle.isHidden = true;
        }
        for i in 0 ..< count {
            pwdCircleArr[i].isHidden = false
        }
    }
    
    
    // MARK: - 显示与隐藏[show close]
    func show(_ view:UIView){
        
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(self)
        window.bringSubview(toFront: self)
        contentView!.transform = CGAffineTransform(scaleX: 1.21, y: 1.21)
        contentView!.alpha = 0;
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.textField.becomeFirstResponder()
            self.contentView!.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.contentView!.alpha = 1;
            
        }, completion: nil)
        
    }
    
    func close(){
        self.removeFromSuperview()
    }
    
    deinit {
        print("delloc ------ PayPwdAlertView ")
    }
    
    
}
