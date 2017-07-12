//
//  CreatNewsVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Kingfisher
class CreatNewsVC: BaseTableViewController, UITextViewDelegate {
    
    @IBOutlet var commentTV: UITextView!
    @IBOutlet var commentPlace: UILabel!
    @IBOutlet var commentCountL: UILabel!
    @IBOutlet var commentPic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentPic.setImage(UIImage.imageWith(AppConst.iconFontName.addIcon.rawValue, fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.init(rgbHex: 0x666666)), for: .normal)
    }
    //选择图片
    @IBAction func commentPicTapped(_ sender: UIButton) {
        
    }
    //点击取消
    @IBAction func cancelItemTapped(_ sender: UIBarButtonItem) {
        
    }
    //发布文章
    @IBAction func publishItemTapped(_ sender: UIBarButtonItem) {
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentPlace.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        commentPlace.isHidden = textView.text.length() > 0
    }
}
