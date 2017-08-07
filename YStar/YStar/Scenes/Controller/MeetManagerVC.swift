//
//  MeetManagerVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

// MARK: - MeetManagerVC
class MeetManagerVC: BaseTableViewController {

    @IBOutlet weak var titlesView: UIView!
    
    @IBOutlet weak var meetTypeButton: UIButton!
    
    @IBOutlet weak var meetOrderButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var selectedButton: UIButton?
    
    // MARK: - 初始化
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupUI()
        
        self.tableView.isScrollEnabled = false
        
        // 默认第一个[meetTypeButton]
        titleViewButtonAction(meetTypeButton)
        
    }
    
    func setupUI() {
        
        var scrollViewFrame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - titlesView.height - 64)
        scrollView.frame = scrollViewFrame
        scrollView.contentSize = CGSize.init(width: kScreenWidth * 2, height: scrollView.height)
        
        if let meetTypeVC = storyboard?.instantiateViewController(withIdentifier: MeetTypeVC.className()) as? MeetTypeVC{
            meetTypeVC.view.frame = scrollViewFrame
            scrollView.addSubview(meetTypeVC.view)
            self.addChildViewController(meetTypeVC)
        }
        if let meetOrderVC = storyboard?.instantiateViewController(withIdentifier: MeetOrderVC.className()) as? MeetOrderVC{
            scrollViewFrame.origin.x = kScreenWidth
            meetOrderVC.view.frame = scrollViewFrame
            scrollView.addSubview(meetOrderVC.view)
            self.addChildViewController(meetOrderVC)
        }
    }
    
    // MARK: - 点击标题按钮Action
    @IBAction func titleViewButtonAction(_ sender: UIButton) {
        
        self.selectedButton?.isSelected = false
        
        self.selectedButton?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor.init(rgbHex: 0xECECEC)
        
        self.selectedButton = sender
        
        let pointSizeOffset = CGPoint.init(x: kScreenWidth * CGFloat(sender.tag - 10), y: 0)
        scrollView.setContentOffset(pointSizeOffset, animated: true)
        scrollView.isPagingEnabled = true
        
    }
    
    // MARK: - UIScrollViewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            
            let tag  = 10 + scrollView.contentOffset.x / kScreenWidth
            
            if let button = view.viewWithTag(Int(tag)) as? UIButton {
                titleViewButtonAction(button)
            }
        }
    }
}



