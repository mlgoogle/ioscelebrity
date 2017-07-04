//
//  UIViewController+Extension.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation
//import XCGLogger
import SVProgressHUD
import Qiniu
extension UIViewController {
    
    static func storyboardViewController<T:UIViewController>(_ storyboard:UIStoryboard) ->T {
        return storyboard.instantiateViewController(withIdentifier: T.className()) as! T;
    }
    
    func storyboardViewController<T:UIViewController>() ->T {
        
        return storyboard!.instantiateViewController(withIdentifier: T.className()) as! T;
    }
    
    
    func errorBlockFunc()->ErrorBlock {
        return { [weak self] (error) in
//            XCGLogger.error("\(error) \(self)")
            self?.didRequestError(error)
        }
    }
    
    func didRequestError(_ error:NSError) {
        self.showErrorWithStatus(error.localizedDescription)
    }
   
    func showErrorWithStatus(_ status: String!) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    func showWithStatus(_ status: String!) {
        SVProgressHUD.show(withStatus: status)
    }
    
    
    //检查text是否为空
    func checkTextFieldEmpty(_ array:[UITextField]) -> Bool {
        for  textField in array {
            if NSString.isEmpty(textField.text)  {
                showErrorWithStatus(textField.placeholder);
                return false
            }
        }
        return true
    }
    
    //关闭模态视图控制器
    func dismissController() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    //打电话
    func didActionTel(_ telPhone:String) {
        let alert = UIAlertController.init(title: "呼叫", message: telPhone, preferredStyle: .alert)
        let ensure = UIAlertAction.init(title: "确定", style: .default, handler: { (action: UIAlertAction) in
            UIApplication.shared.openURL(URL(string: "tel://\(telPhone)")!)
        })
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: { (action: UIAlertAction) in
            
        })
        alert.addAction(ensure)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}
