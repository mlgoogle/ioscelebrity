//
//  DateSelectorView.swift
//  YStar
//
//  Created by MONSTER on 2017/7/14.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

protocol DateSelectorViewDelegate {
    
    func chooseDate(datePickerView : DateSelectorView , date : Date)
}

class DateSelectorView: UIView {

    var pickerDelegate : DateSelectorViewDelegate?
    
    private let defaultHeight : CGFloat = 260
    
    var datePicker : UIDatePicker = UIDatePicker()
    
    private var backgroundBtn: UIButton = UIButton()
    
    // MARK: - 初始化
    init(delegate: DateSelectorViewDelegate) {
       
        pickerDelegate = delegate
        
        let v_frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: defaultHeight)
        super.init(frame: v_frame)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        view.backgroundColor = UIColor.init(rgbHex: 0xE6E6E6)
        self.addSubview(view)
        
        let cancelBtn = UIButton(type: UIButtonType.system)
        cancelBtn.frame = CGRect(x: 0, y:  0, width: 60, height: 44)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.setTitle("取 消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        cancelBtn.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        let doneBtn = UIButton(type: UIButtonType.system)
        doneBtn.frame = CGRect(x: kScreenWidth - 60, y: 0, width: 60, height: 44)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneBtn.setTitle("确 定", for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneBtn.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        self.addSubview(doneBtn)
        
        backgroundBtn = UIButton(type: UIButtonType.system)
        backgroundBtn.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height:kScreenHeight)
        backgroundBtn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        backgroundBtn.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 44, width: kScreenWidth, height: defaultHeight - 44))
        self.datePicker.datePickerMode = UIDatePickerMode.date
        self.datePicker.locale = Locale(identifier: "zh_CN")
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.addTarget(self, action: #selector(self.dateChoosePressed(datePicker:)), for: .valueChanged)
        self.addSubview(self.datePicker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dateChoosePressed(datePicker: UIDatePicker) {}
    
    // MARK: - 按钮相关[确定 取消]
    func doneButtonClick() {
        pickerDelegate?.chooseDate(datePickerView: self, date: datePicker.date)
        self.hiddenPicker()
    }
    
    func cancelButtonClick(btn:UIButton) {
        
        self.hiddenPicker()
    }
    
    // MARK: - 显示隐藏 [show hide]
    public func showPicker() {
        UIApplication.shared.keyWindow?.addSubview(self.backgroundBtn)
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundBtn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.top = kScreenHeight - self.defaultHeight
        }) { (finished: Bool) in
        }
    }
    
    private func hiddenPicker() {
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundBtn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.top = kScreenHeight
        }) { (finished: Bool) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.backgroundBtn.removeFromSuperview()
        }
    }
    
    deinit {
        print("DateSelectorView-------dealloc---------")
    }
}
