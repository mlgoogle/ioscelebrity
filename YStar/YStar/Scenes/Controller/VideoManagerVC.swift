//
//  VideoManagerVC.swift
//  YStar
//
//  Created by mu on 2017/8/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class VideoQuestionCell: OEZTableViewCell{
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var videoReplyBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subContentView: UIView!
    @IBOutlet weak var subTimeLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var viewIconImage: UIImageView!
    var question = QuestionModel()
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        subContentView.isUserInteractionEnabled = true
        viewIconImage.image = UIImage.imageWith("\u{e671}", fontSize: CGSize.init(width: 26, height: 24), fontColor: UIColor.init(rgbHex: 0x666666))

    }
    
    override func update(_ data: Any!) {
        if let model = data as? QuestionModel{
            question = model
            iconImage.kf.setImage(with: URL.init(string: model.headUrl))
            nameLabel.text =  model.nickName
            timeLabel.text = "定制  \(Date.yt_convertDateStrWithTimestemp(model.ask_t, format: "yyyy-MM-dd"))"
            subTimeLabel.text = "\((model.c_type + 1)*15)S"
            contentLabel.text = model.uask
            viewIconImage.isHidden = model.answer_t == 0
            viewCountLabel.isHidden = model.answer_t == 0
            if model.answer_t == 0 {
                videoBtn.backgroundColor = UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue)
                videoBtn.setTitle("    未完成    ", for: .normal)
                videoBtn.contentHorizontalAlignment = .center
                videoBtn.setTitleColor(UIColor.white, for: .normal)
                videoReplyBtn.isHidden = true
            }else{
                videoBtn.backgroundColor = UIColor.white
                videoBtn.setTitle("观看回答", for: .normal)
                videoBtn.contentHorizontalAlignment = .left
                videoBtn.setTitleColor(UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue), for: .normal)
                videoReplyBtn.isHidden = model.video_url.length() == 0
                viewCountLabel.text = "观看 \(model.s_total)"
            }
            
        }
    }
    
    @IBAction func videoBtnTapped(_ sender: UIButton) {
        if question.answer_t == 0 {
            didSelectRowAction(100, data: question)
        }else{
            didSelectRowAction(UInt(sender.tag), data: question)
        }
    }
    
}


class VideoManagerVC: BaseListTableViewController, OEZTableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }

    override func didRequest() {
        let model = QuestionsRequestModel()
        model.pos = pageIndex == 0 ? 0 : dataSource?.count ?? 0 + 1
        model.count = 10
        model.aType = 1
        AppAPIHelper.commen().userQuestions(requestModel: model, complete: { [weak self](response) in
            if let models = response as? [QuestionModel]{
                self?.didRequestComplete(models as AnyObject?)
            }else {
                self?.didRequestComplete(nil)
            }
            self?.setIsLoadData(true)
            return nil
        }, error: errorBlockFunc())
    }
    
    override func didRequest(_ pageIndex: Int) {
        
        let model = QuestionsRequestModel()
        model.pos = pageIndex == 1 ? 0 : dataSource?.count ?? 0 + 1
        model.count = 10
        model.aType = 1 
        AppAPIHelper.commen().userQuestions(requestModel: model, complete: { [weak self](response) in
            if let models = response as? [QuestionModel]{
                self?.didRequestComplete(models as AnyObject?)
            }else {
                self?.setupLoadMore()
                self?.didRequestComplete(nil)
            }
            self?.tableView.reloadData()
            return nil
        }, error: errorBlockFunc())
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VideoQuestionCell.className()
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        if action == 100{
            if let vc = storyboard?.instantiateViewController(withIdentifier: VideoAnswerVC.className()) as? VideoAnswerVC,
                let model = data as? QuestionModel{
                vc.model = model
                vc.complete = { [weak self](result) in
                    self?.didRequest(1)
                   return nil
                }
                _ = navigationController?.pushViewController(vc, animated: true)
            }
        }
        if action == 101{
            if let question = data as? QuestionModel{
                if let vc = storyboard?.instantiateViewController(withIdentifier: PlayVideoVC.className()) as? PlayVideoVC,
                    let model = data as? QuestionModel{
                    vc.question = model
                    vc.bgImageUrl = model.thumbnailS
                    present(vc, animated: true, completion: {
                        vc.play(qiniuHelper.shared().qiniuHeader+question.sanswer)
                    })
                }
            }
        }
        if action == 102{
            if let question = data as? QuestionModel{
                if let vc = storyboard?.instantiateViewController(withIdentifier: PlayVideoVC.className()) as? PlayVideoVC,
                    let model = data as? QuestionModel{
                    vc.question = model
                    vc.bgImageUrl = model.thumbnail
                    present(vc, animated: true, completion: {
                        vc.play(qiniuHelper.shared().qiniuHeader+question.video_url)
                    })
                }
            }
        }
    }
}
