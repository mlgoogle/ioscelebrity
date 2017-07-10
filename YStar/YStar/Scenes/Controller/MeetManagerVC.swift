//
//  MeetManagerVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MeetManagerVC: BaseTableViewController {

    weak var scrollView = UIScrollView()
    
    weak var titlesView = UIView()
    
    weak var indicatorView = UIView()
    
    let titleArrM = ["约见类型","约见订单"]
    
    override func loadView() {
        
        // 将tableView替换成view
        let sview = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        sview.backgroundColor = UIColor.red
        view = sview
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        print("====\(self.view)")
        
    }

    func setupUI() {
        
        let meetTypeVC = UIStoryboard.init(name: "Meet", bundle: nil).instantiateViewController(withIdentifier: "MeetTypeVC")
        self.addChildViewController(meetTypeVC)
        
        let meetOrderVC =  UIStoryboard.init(name: "Meet", bundle: nil).instantiateViewController(withIdentifier: "MeetOrderVC")
        self.addChildViewController(meetOrderVC)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor.orange
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
        
        scrollView.isPagingEnabled = true
        
        let scrollviewSize =  CGSize.init(width: CGFloat(self.childViewControllers.count) * scrollView.width, height: 0)
        scrollView.contentSize = scrollviewSize
        scrollView.delegate = self;
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
