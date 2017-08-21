//
//  StarNewsVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import YYText
import SVProgressHUD
import MJRefresh
import MWPhotoBrowser
class NewsCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var newsPic: UIImageView!
    @IBOutlet weak var newsLabel: YYLabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var thumbUpBtn: UIButton!
    @IBOutlet weak var CommentBtn: UIButton!
    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    var newsPicUrl = ""
    
    override func awakeFromNib() {
        showBtnTapped(showBtn)
        thumbUpBtn.setImage(UIImage.imageWith(AppConst.iconFontName.thumbIcon.rawValue, fontSize: CGSize.init(width: 16, height: 16), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.closeColor.rawValue)), for: .normal)
        CommentBtn.setImage(UIImage.imageWith(AppConst.iconFontName.commentIcon.rawValue, fontSize: CGSize.init(width: 16, height: 16), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.closeColor.rawValue)), for: .normal)
        newsLabel.textParser = YParser.share()
        newsPic.isUserInteractionEnabled = true
        let showPicGesture = UITapGestureRecognizer.init(target: self, action: #selector(showPicGestureTapped(_:)))
        newsPic.addGestureRecognizer(showPicGesture)

    }
    override func update(_ data: Any!) {
        if let model = data as? CircleListModel{
            let userIcon = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
            iconImage.kf.setImage(with: URL(string:qiniuHelper.shared().qiniuHeader +  model.head_url), placeholder: userIcon)
            nameLabel.text =  model.symbol_name
            newsLabel.text = model.content
            newsPic.kf.setImage(with: URL(string:qiniuHelper.shared().qiniuHeader +  model.pic_url), placeholder: nil)
            newsPicUrl = model.pic_url
            timeLabel.text = Date.marginDateStr(Int(model.create_time))
        }
    }
    
    @IBAction func showBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.25, animations: { [weak self] (animation) in
            self?.showView.isHidden = sender.isSelected
        })
    }
    
    @IBAction func thumbUpOrCommentBtnTapped(_ sender: UIButton) {
        didSelectRowAction(UInt(sender.tag))
        showBtnTapped(showBtn)
    }
    
    func showPicGestureTapped(_ gesture: UITapGestureRecognizer) {
        didSelectRowAction(UInt(103), data: newsPicUrl)
    }
}

class ThumbupCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var thumbupNames: UILabel!
    @IBOutlet weak var thumbUpHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith(AppConst.iconFontName.thumpUpIcon.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    override func update(_ data: Any!) {
        if let model = data as? CircleListModel{
            contentView.isHidden = model.approve_list.count == 0
            thumbupNames.text = model.approveName
        }
    }
}

class CommentCell: OEZTableViewCell {
    @IBOutlet var commentLabel: YYLabel!
    
    override func awakeFromNib() {
        let replyGesture = UITapGestureRecognizer.init(target: self, action: #selector(replyGestureTapped(_:)))
        commentLabel.addGestureRecognizer(replyGesture)
        commentLabel.isUserInteractionEnabled = true
        commentLabel.textParser = YParser.share()
    }
    func update(_ data: Any!, index:IndexPath) {
        if let listModel = data as? CircleListModel{
            let model = listModel.comment_list[index.row-2]
            var comment = "\(model.user_name):\(model.content)"
            if model.direction == 1{
                comment = "\(listModel.symbol_name)回复\(model.user_name):\(model.content)"
            }
            if model.direction == 2{
                comment = "\(model.user_name)回复\(listModel.symbol_name):\(model.content)"
            }
            
            let contentAttribute = NSMutableAttributedString.init(string: comment)
            contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: comment.length()))

            if model.direction == 0 {
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x0092ca), range: NSRange.init(location: 0, length: model.user_name.length()))
            }
            if model.direction == 1{
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x185CA5), range: NSRange.init(location: 0, length: listModel.symbol_name.length()))
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x0092ca), range: NSRange.init(location: listModel.symbol_name.length()+2, length: model.user_name.length()))
                
            }
            if model.direction == 2{
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x185CA5), range: NSRange.init(location: model.user_name.length()+2, length: listModel.symbol_name.length()))
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x0092ca), range: NSRange.init(location: 0, length: model.user_name.length()))
            }
            commentLabel.attributedText = contentAttribute
        }
    }
    func replyGestureTapped(_ gesture: UITapGestureRecognizer){
        didSelectRowAction(102, data: "")
    }
}

class StarNewsVC: BaseTableViewController, OEZTableViewDelegate, MWPhotoBrowserDelegate {
    
    var tableData: [CircleListModel] = []
    var newsPicUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestCycleData(0)
        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            self.requestCycleData(self.tableData.count)
        })
        requestCycleData(0)
    }
    
    enum cellAction: Int {
        case thumbUp = 100
        case comment = 101
        case reply = 102
        case showPic = 103
    }
    
    func endRefresh() {
        if tableView.mj_header.state == .refreshing {
            tableView.mj_header.endRefreshing()
        }
        if tableView.mj_footer.state == .refreshing {
            tableView.mj_footer.endRefreshing()
        }
    }
    
    func requestCycleData(_ position: Int) {
        let param = CircleListRequestModel()
        param.pos = Int64(position)
        AppAPIHelper.commen().requestStarCircleList(requestModel: param, complete: { [weak self](result) in
            if let data = result as? [CircleListModel]{
                for model in data{
                    model.caclulateHeight()
                }
                if position == 0{
                    self?.tableData = data
                }else{
                    self?.tableData += data
                }
                self?.tableView.reloadData()
            }
            self?.endRefresh()
            return nil
        }, error: errorBlockFunc())
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = tableData[section]
        return model.comment_list.count+2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = tableData[indexPath.section]
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.className()) as? NewsCell
            cell?.update(model)
            return cell!
        }
        
        if indexPath.row == 1{
            let cell  = tableView.dequeueReusableCell(withIdentifier: ThumbupCell.className()) as? ThumbupCell
            cell?.update(model)
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.className()) as? CommentCell
        cell?.update(model, index:indexPath)
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        switch indexPath.row {
        case 0:
            return NewsCell.className()
        case 1:
            return ThumbupCell.className()
        default:
            return CommentCell.className()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = tableData[indexPath.section]
        if indexPath.row == 0{
            return model.headerHeight
        }
        if indexPath.row == 1{
            return model.thumbUpHeight
        }
        let commentModel = model.comment_list[indexPath.row - 2]
        return commentModel.circleHeight
    }
    
    override func isSections() -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        let model = tableData[indexPath.section]
        switch action {
        case cellAction.reply.rawValue:
            let commentModel = model.comment_list[indexPath.row-2]
            if commentModel.direction == 1{
                return
            }
            let keyboardVC = KeyboardInputViewController()
            keyboardVC.modalPresentationStyle = .custom
            keyboardVC.modalTransitionStyle = .crossDissolve
            keyboardVC.sendMessage = { [weak self](message) in
                let param = CommentCircleModel()
                param.content = message as! String
                param.star_code = model.symbol
                param.circle_id = model.circle_id
                param.direction = 1
                AppAPIHelper.commen().starCommentCircle(requestModel: param, complete: { (response) in
                    if let result = response as? ResultModel{
                        if result.result == 1{
                            SVProgressHUD.showSuccessMessage(SuccessMessage: "回复成功", ForDuration: 2, completion: {
                                let comment = CircleCommentModel()
                                comment.uid = ShareModelHelper.instance().uid
                                comment.user_name = ShareModelHelper.instance().userinfo.nick_name
                                comment.direction = 1
                                comment.priority = 0
                                comment.content = message as! String
                                comment.calculateHeight()
                                model.comment_list.append(comment)
                                tableView.reloadData()
                            })
                        }
                    }
                    return nil
                }, error: self?.errorBlockFunc())
                return nil
            }
            present(keyboardVC, animated: true, completion: nil)
        case cellAction.showPic.rawValue:
            if let url = data as? String{
                newsPicUrl = url
                let vc = PhotoBrowserVC(delegate: self)
                present(vc!, animated: true, completion: nil)
            }
        default:
            print("")
        }
        
    }
    
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return 1
    }
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let photo = MWPhoto(url:URL(string:qiniuHelper.shared().qiniuHeader +  newsPicUrl))
        return photo
    }
}
