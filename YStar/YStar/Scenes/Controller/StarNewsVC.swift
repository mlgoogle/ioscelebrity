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

// MARK: - 朋友圈信息CELL
class NewsCell: OEZTableViewCell {
    
    @IBOutlet var iconImage: UIImageView!   // 头像icon
    
    @IBOutlet var nameLabel: UILabel!       // 名称
    
    @IBOutlet weak var newsPic: UIImageView! // 个人朋友圈配图
    
    @IBOutlet weak var newsLabel: YYLabel!  //  个人朋友圈内容
    
    @IBOutlet weak var timeLabel: UILabel!  // 发布时间
    
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var thumbUpBtn: UIButton!    // 点赞
    @IBOutlet weak var CommentBtn: UIButton!    // 评论
    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint! // 个人朋友圈内容高度
    
    var newsPicUrl = ""
    
    override func awakeFromNib() {
//        if true{
//            //        showBtn.setImage(UIImage.imageWith(AppConst.iconFontName.showIcon.rawValue, fontSize: CGSize.init(width: 22, height: 17), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.linkColor.rawValue)), for: .normal)
//        }else{
//            showBtn.isEnabled = false
//        }
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
            iconImage.kf.setImage(with: URL.init(string: model.head_url), placeholder: userIcon)
            nameLabel.text =  model.symbol_name
            newsLabel.text = model.content
            //新闻图片占位图
            let newsPlace = UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: newsPic.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
            newsPic.kf.setImage(with: URL.init(string: model.pic_url), placeholder: newsPlace)
            //计算文案高度
            let contentAttribute = NSMutableAttributedString.init(string: model.content)
            contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: model.content.length()))
            let size  = CGSize.init(width: newsLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)
            let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
            contentHeight.constant = (layout?.textBoundingSize.height)!
            newsPicUrl = model.pic_url
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

// MARK: - 朋友圈点赞Cell
class ThumbupCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var thumbupNames: UILabel!
    @IBOutlet weak var thumbUpHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith(AppConst.iconFontName.thumpUpIcon.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    override func update(_ data: Any!) {
        if let model = data as? CircleListModel{
            var approveName = ""
            for approve in model.approve_list{
                approveName += "\(approve.user_name),"
            }
            //计算文案高度
            let contentAttribute = NSMutableAttributedString.init(string: approveName)
            contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: approveName.length()))
            let size  = CGSize.init(width: thumbupNames.frame.width-40 , height: CGFloat.greatestFiniteMagnitude)
            let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
            thumbUpHeight.constant = (layout?.textBoundingSize.height)!
            thumbupNames.attributedText = contentAttribute
        }
    }
}

// MARK: - 朋友圈评论Cell
class CommentCell: OEZTableViewCell {
    @IBOutlet var commentLabel: YYLabel!
    @IBOutlet weak var commentHeight: NSLayoutConstraint!
    
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
            //计算文案高度
            let contentAttribute = NSMutableAttributedString.init(string: comment)
            contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: comment.length()))
            let size  = CGSize.init(width: commentLabel.frame.width , height: CGFloat.greatestFiniteMagnitude)
            let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
            commentHeight.constant = (layout?.textBoundingSize.height)!
            if model.direction == 0 {
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x0092ca), range: NSRange.init(location: 0, length: model.user_name.length()))
            }
            if model.direction == 1{
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x8c0808), range: NSRange.init(location: 0, length: listModel.symbol_name.length()))
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x0092ca), range: NSRange.init(location: listModel.symbol_name.length()+2, length: model.user_name.length()))
                
            }
            if model.direction == 2{
                contentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(rgbHex: 0x8c0808), range: NSRange.init(location: model.user_name.length()+2, length: listModel.symbol_name.length()))
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
    
    enum cellAction: Int {
        case thumbUp = 100
        case comment = 101
        case reply = 102    // 回复
        case showPic = 103  // 点开查看大图
    }
    
    // MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发现明星"
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestCycleData(0)
        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            self.requestCycleData(self.tableData.count)
        })
        requestCycleData(0)
    }
    
    // MARK: - 请求明星个人朋友圈
    func requestCycleData(_ position: Int) {
        let param = CircleListRequestModel()
        param.pos = Int64(position)
        AppAPIHelper.commen().requestStarCircleList(requestModel: param, complete: { [weak self](result) in
            if let data = result as? [CircleListModel]{
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
    
    // 结束刷新
    func endRefresh() {
        if tableView.mj_header.state == .refreshing {
            tableView.mj_header.endRefreshing()
        }
        if tableView.mj_footer.state == .refreshing {
            tableView.mj_footer.endRefreshing()
        }
    }
    
    // MARK: - UITableViewDataSource,UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = tableData[section] as? CircleListModel{
            return model.comment_list.count+(model.approve_list.count > 0 ? 2:1)
        }
        return 0
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
    override func isSections() -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        let model = tableData[indexPath.section]
        switch action {
        case cellAction.thumbUp.rawValue:
            for approve in model.approve_list{
                if approve.uid == Int64(ShareModelHelper.instance().uid){
                    SVProgressHUD.showWainningMessage(WainningMessage: "您已经点赞过了", ForDuration: 2, completion: nil)
                    return
                }
            }
            
            let param = ApproveCircleModel()
            param.star_code = model.symbol
            param.circle_id = model.circle_id
            AppAPIHelper.commen().approveCircle(requestModel: param, complete: { (response) in
                if let result = response as? ResultModel{
                    if result.result == 1{
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "点赞成功", ForDuration: 2, completion: { 
                            let user = ApproveModel()
                            user.uid = Int64(ShareModelHelper.instance().uid)
                            user.user_name = ShareModelHelper.instance().userinfo.nick_name
                            model.approve_list.append(user)
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        })
                    }
                }
                return nil
            }, error: errorBlockFunc())
            break
        case cellAction.comment.rawValue:
            let keyboardVC = KeyboardInputViewController()
            keyboardVC.modalPresentationStyle = .custom
            keyboardVC.modalTransitionStyle = .crossDissolve
            keyboardVC.sendMessage = { [weak self] (message) in
                let param = CommentCircleModel()
                param.content = message as! String
                param.star_code = model.symbol
                param.circle_id = model.circle_id
                AppAPIHelper.commen().commentCircle(requestModel: param, complete: { (response) in
                    if let result = response as? ResultModel{
                        if result.result == 1{
                            SVProgressHUD.showSuccessMessage(SuccessMessage: "评论成功", ForDuration: 2, completion: {
                                let comment = CircleCommentModel()
                                comment.uid = ShareModelHelper.instance().uid
                                comment.user_name = ShareModelHelper.instance().userinfo.nick_name
                                comment.direction = 0
                                comment.priority = 0
                                comment.content = message as! String
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
        let photo = MWPhoto(url:URL(string: newsPicUrl))
        return photo
    }
}
