//
//  CreatNewsVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Kingfisher
import YYText
import SVProgressHUD

class CreatNewsVC: BaseTableViewController,
                   YYTextViewDelegate,
                   UIImagePickerControllerDelegate,
                   UINavigationControllerDelegate{
    
    @IBOutlet var commentTV: YYTextView!
    @IBOutlet var commentCountL: UILabel!
    @IBOutlet var commentPic: UIButton!
    
    var imageUrl = ""
    
    lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentPic.setImage(UIImage.imageWith(AppConst.iconFontName.addIcon.rawValue, fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.init(rgbHex: 0x666666)), for: .normal)
    }
    
    //选择图片
    @IBAction func commentPicTapped(_ sender: UIButton) {
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage
            ] as? UIImage{
            UIImage.qiniuUploadImage(image: image, imageName: "Cycle", complete: { [weak self] (result) in
                if let qiniuUrl = result as? String{
                    self?.imageUrl = qiniuHelper.shared().qiniuHeader + qiniuUrl
                }
                return nil
            }, error: nil)
            commentPic.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
  
    //发布文章
    @IBAction func publishItemTapped(_ sender: UIBarButtonItem) {
        if commentTV.text.length() == 0{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入内容", ForDuration: 2, completion: nil)
            return
        }
        
        if imageUrl.length() == 0{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入图片", ForDuration: 2, completion: nil)
            return
        }
        
        let model = SendCircleRequestModel()
        model.content = commentTV.text
        model.picurl = imageUrl
        AppAPIHelper.commen().sendCircle(requestModel: model, complete: { [weak self](result) in
            if let resultModle = result as? SendCircleResultModel{
                if resultModle.circle_id > 0{
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "发布成功", ForDuration: 2, completion: { 
                        let _ = self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
            return nil
        }, error: errorBlockFunc())
    }

    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let content = textView.text.replacingCharacters(in: textView.text.range(from: range)!, with: text)
        let result  = 200 - content.length()
        commentCountL.text = "\(result)\\200"
        return result > 0
    }
}
