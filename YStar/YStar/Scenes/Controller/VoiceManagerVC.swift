//
//  VoiceManagerVC.swift
//  YStar
//
//  Created by mu on 2017/8/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class VoiceQuestionCell: OEZTableViewCell{
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subContentView: UIView!
    @IBOutlet weak var subTimeLabel: UILabel!
    var question = QuestionModel()
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        let voiceImage = UIImage.imageWith("\u{e672}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        voiceBtn.setImage(nil, for: .normal)
        voiceBtn.setImage(voiceImage, for: .selected)
        subContentView.isUserInteractionEnabled = true
    }
    
    override func update(_ data: Any!) {
        if let model = data as? QuestionModel{
            question = model
            iconImage.kf.setImage(with: URL.init(string: model.headUrl))
            nameLabel.text =  model.nickName
            timeLabel.text = "定制  \(Date.yt_convertDateStrWithTimestemp(model.ask_t, format: "yyyy-MM-dd"))"
            subTimeLabel.text = "\((model.c_type + 1)*15)S"
            contentLabel.text = model.uask
            if model.sanswer == "NULL" {
                voiceBtn.backgroundColor = UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue)
                voiceBtn.setTitle("未完成", for: .selected)
                voiceBtn.setTitle("未完成", for: .normal)
            }else{
                voiceBtn.backgroundColor = UIColor.init(rgbHex: 0xeaeaea)
                voiceBtn.setTitle("     ", for: .normal)
                voiceBtn.setTitle("     ", for: .selected)
            }
            voiceBtn.isSelected = model.sanswer != "NULL"
        }
    }
    
    @IBAction func voiceBtnTapped(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "")
        
        if sender.isSelected {
            let urlStr = qiniuHelper.shared().qiniuHeader + question.sanswer
            VoicePlayerHelper.shared().play(urlStr)
        }else{
            didSelectRowAction(100, data: question)
        }
    }
    
}


class VoiceManagerVC: BasePageListTableViewController,OEZTableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    override func didRequest(_ pageIndex: Int) {
        let model = QuestionsRequestModel()
        model.pos = pageIndex == 0 ? 0 : dataSource?.count ?? 0
        model.count = 10
        AppAPIHelper.commen().userQuestions(requestModel: model, complete: { [weak self](response) in
            if let models = response as? [QuestionModel]{
                self?.didRequestComplete(models as AnyObject?)
            }
            return nil
        }, error: errorBlockFunc())
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VoiceQuestionCell.className()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        if action == 100{
            if let vc = storyboard?.instantiateViewController(withIdentifier: VoiceAnswerVC.className()) as? VoiceAnswerVC,
                let model = data as? QuestionModel{
                vc.model = model
                _ = navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
