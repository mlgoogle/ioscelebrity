//
//  MeetManagerVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit


// MARK: - 自定义按钮
class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setTitleColor(UIColor.init(hexString: "#C2CFD8"), for: .normal)
        self.setTitleColor(UIColor.init(hexString: "#8C0808"), for: .selected)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 取消高亮
    override var isHighlighted: Bool {
        set{
            
        }
        get {
            return false
        }
    }
}

// MARK: - MeetManagerVC
class MeetManagerVC: BaseTableViewController {

    weak var scrollView = UIScrollView()
    
    weak var titlesView = UIView()
    
    weak var indicatorView = UIView()
    
    // 记录选中的按钮
    weak var selectedButton = TitleButton()
    
    let titleArrM = ["约见类型","约见订单"]
    
    private lazy var titleButtonArrM : NSMutableArray = {
        var tempArr = NSMutableArray()
        return tempArr
    }()
    
    
    override func loadView() {
        // 将tableView替换成view
        let currentView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        currentView.backgroundColor = UIColor.white
        view = currentView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupUI()
        
    }

    func setupUI() {
        
        let meetTypeVC = UIStoryboard.init(name: "Meet", bundle: nil).instantiateViewController(withIdentifier: "MeetTypeVC")
        self.addChildViewController(meetTypeVC)
        let meetOrderVC =  UIStoryboard.init(name: "Meet", bundle: nil).instantiateViewController(withIdentifier: "MeetOrderVC")
        self.addChildViewController(meetOrderVC)
        
        // 不用自动调整contentInset
        self.automaticallyAdjustsScrollViewInsets = false
        
        // scrollView
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize.init(width: CGFloat(self.childViewControllers.count) * scrollView.width, height: 0)
        scrollView.delegate = self;
        self.scrollView = scrollView
        // 默认选择第一个
        self.scrollViewDidEndScrollingAnimation(scrollView)
        
        // 标题view
        let titlesView = UIView()
        titlesView.backgroundColor = UIColor.init(white: 1.0, alpha: 1.0)
        titlesView.frame = CGRect.init(x: 0, y: 64, width: self.view.width, height: 40)
        self.view.addSubview(titlesView)
        self.titlesView = titlesView
        
        let count = self.childViewControllers.count
        
        let titleButtonW = titlesView.width / CGFloat(count)
        let titleButtonH = titlesView.height
        
        for i in 0..<count {
            
            let titleButton = TitleButton(type: .custom)
            titlesView.addSubview(titleButton)
            titleButton.addTarget(self, action: #selector(titleButtonClick(_ :)), for: .touchUpInside)
            
            self.titleButtonArrM.add(titleButton)
            let titleString = self.titleArrM[i]
            titleButton.setTitle(titleString, for: .normal)
            
            // 位置
            let titleButtonY = 0;
            let titleButtonX = CGFloat(i) * titleButtonW
            titleButton.frame = CGRect(x: titleButtonX, y: CGFloat(titleButtonY), width: titleButtonW, height: titleButtonH)
            
        }
        
        // 指示器view
        let indicatorView = UIView()
        indicatorView.backgroundColor = UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)
        indicatorView.height = 1.5;
        indicatorView.y = (self.titlesView?.height)! - indicatorView.height
        titlesView.addSubview(indicatorView)
        
        self.indicatorView = indicatorView
        
        // 默认选中第一个按钮
        let firstTitleButton = self.titleButtonArrM.firstObject as! TitleButton
        firstTitleButton.titleLabel?.sizeToFit()
        indicatorView.width = (firstTitleButton.titleLabel?.width)!
        indicatorView.centerX = firstTitleButton.centerX
        titleButtonClick(firstTitleButton)

    }
    
    
    // 按钮点击
    func titleButtonClick(_ titleButton : TitleButton) {
        
        self.selectedButton?.isSelected = false

        titleButton.isSelected = true
        
        self.selectedButton = titleButton
        
        UIView.animate(withDuration: 0.25) {
            self.indicatorView?.width = (self.selectedButton?.titleLabel?.width)!
            self.indicatorView?.centerX = (self.selectedButton?.centerX)!
        }

        var offset = self.scrollView?.contentOffset
        let index = self.titleButtonArrM.index(of: titleButton)
        offset?.x = (self.scrollView?.width)! * CGFloat(index)
        
        self.scrollView?.setContentOffset(offset!, animated: true)
        
    }
    
    
    // MARK: - UIScrollViewDelegate
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        
        let willShowChildVC = childViewControllers[index]
        
        if willShowChildVC.isViewLoaded { return }
        
        willShowChildVC.view.frame = scrollView.bounds
        
        scrollView.addSubview(willShowChildVC.view)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        
        let button = titlesView!.subviews[index] as! TitleButton
        
        titleButtonClick(button)
    }    
}



