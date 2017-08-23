//
//  MeetOrderDetailVC.swift
//  YStar
//
//  Created by MONSTER on 2017/7/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

class MeetOrderDetailVC: BaseTableViewController {

    // 同意按钮
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    var model:MeetOrderModel = MeetOrderModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "约见订单详情"
        initUI()
    }
    
    func initUI() {
        headerImage.kf.setImage(with: URL(string:qiniuHelper.shared().qiniuHeader +  model.headurl), placeholder: UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue)))
        nameLabel.text = model.nickname
        timeLabel.text = "时间： \(model.appoint_time)"
        locationLabel.text = "地点： \(model.meet_city)"
        typeLabel.text = "约见类型： \(model.name)"
        contentLabel.text = "约见备注： \(model.comment)"
        agreeButton.isHidden = model.meet_type == 4
        
    }
    
    
    @IBAction func agreeButtonAction(_ sender: UIButton) {
        let param = AgreeOrderRequest()
        param.starcode = model.starcode
        param.meettype = 4
        param.meetid = model.id
        SVProgressHUD.showProgressMessage(ProgressMessage: "处理中...")
        AppAPIHelper.commen().agreeOrder(requestModel: param, complete: { [weak self](result) in
            if let model = result as? ResultModel{
                if model.result == 1{
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "已同意", ForDuration: 2, completion: {
                        _ = self?.navigationController?.popViewController(animated: true)
                    })
                   
                }
            }
            return nil
        }, error: errorBlockFunc())
    }

}
