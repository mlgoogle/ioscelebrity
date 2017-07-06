//
//  BenifityVC.swift
//  YStar
//
//  Created by mu on 2017/7/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BenifityVC: BaseTableViewController {

    @IBOutlet weak var testIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testIcon.image = UIImage.imageWith("\u{e64a}", fontSize: testIcon.frame.size, fontColor: UIColor.red)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector(rightButtonClick))
        
    }

    func rightButtonClick() {

        let nextVC = nextViewViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
