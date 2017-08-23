//
//  FansListViewController.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FansManagerVC: BaseTableViewController {

    @IBOutlet weak var choseView: UIView!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var contentSV: UIScrollView!
    
    private var lastBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        self.tableView.isScrollEnabled = false
        
        chatOrNewsBtnTapped(chatBtn)
    }
    
    @IBAction func chatOrNewsBtnTapped(_ sender: UIButton) {
    
        self.lastBtn?.isSelected = false
        self.lastBtn?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor.init(rgbHex: 0xECECEC)
        self.lastBtn = sender
        
        contentSV.setContentOffset(CGPoint.init(x: kScreenWidth*CGFloat(sender.tag-100), y: 0), animated: true)
        contentSV.isPagingEnabled = true
    }

    func initUI() {
        var contentFrame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-choseView.frame.size.height-64)
        contentSV.frame = contentFrame
        contentSV.contentSize = CGSize.init(width: kScreenWidth*2, height: contentFrame.size.height)
        if let fansListVC = storyboard?.instantiateViewController(withIdentifier: FansListVC.className()) as? FansListVC{
            fansListVC.view.frame = contentFrame
            contentSV.addSubview(fansListVC.view)
            addChildViewController(fansListVC)
        }
        if let newsVC = storyboard?.instantiateViewController(withIdentifier: StarNewsVC.className()) as? StarNewsVC{
            contentFrame.origin.x = kScreenWidth
            newsVC.view.frame = contentFrame
            contentSV.addSubview(newsVC.view)
            addChildViewController(newsVC)
        }
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == contentSV{
            let tag  = 100 + contentSV.contentOffset.x/kScreenWidth
            if let btn = choseView.viewWithTag(Int(tag)) as? UIButton{
                chatOrNewsBtnTapped(btn)
            }
        }
    }
}
