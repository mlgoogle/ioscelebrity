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
            if model.answer_t == 0 {
                voiceBtn.backgroundColor = UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue)
                voiceBtn.setTitle("未完成", for: .normal)
                voiceBtn.setImage(nil, for: .normal)
            }else{
                voiceBtn.backgroundColor = UIColor.init(rgbHex: 0xeaeaea)
                voiceBtn.setTitle("     ", for: .normal)
                let voiceImage = UIImage.init(named: "voice_4")
                voiceBtn.setImage(voiceImage, for: .normal)
            }
        }
    }
    
    @IBAction func voiceBtnTapped(_ sender: UIButton) {
        if question.answer_t > 0 {
            didSelectRowAction(101, data: question)
        }else{
            didSelectRowAction(100, data: question)
        }
    }
    
}


class VoiceManagerVC: BasePageListTableViewController,OEZTableViewDelegate {

    var voiceBtn: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VoicePlayerHelper.shared().resultBlock =  { (result) in
            if let status = result as? PLPlayerStatus{
                if status == .statusStopped{
                    VoicePlayerHelper.shared().doChanggeStatus(4)
                    self.voiceBtn.setImage(UIImage.init(named: "voice_4"), for: .normal)
                }
                if status == .statusPaused{
                    VoicePlayerHelper.shared().doChanggeStatus(4)
                    self.voiceBtn.setImage(UIImage.init(named: "voice_4"), for: .normal)
                }
                if status == .statusPreparing{
                    VoicePlayerHelper.shared().doChanggeStatus(0)
                    VoicePlayerHelper.shared().resultCountDown = { (result) in
                        if let response = result as? Int{
                            let image = UIImage.init(named: String.init(format: "voice_%d",response))
                            self.voiceBtn.setImage(image, for: .normal)
                        }
                        return nil
                    }
                }
                if status == .statusError{
                    VoicePlayerHelper.shared().doChanggeStatus(4)
                    self.voiceBtn.setImage(UIImage.init(named: "voice_4"), for: .normal)
                }
            }
            return nil
        }
    }
    
    override func didRequest(_ pageIndex: Int) {
    
        let model = QuestionsRequestModel()
        model.pos = pageIndex == 1 ? 0 : dataSource?.count ?? 0 + 1
        model.count = 10
        model.aType = 2
        AppAPIHelper.commen().userQuestions(requestModel: model, complete: { [weak self](response) in
            if let models = response as? [QuestionModel] {
                for model in models{
                    model.calculateCellHeight()
                }
                self?.didRequestComplete(models as AnyObject?)
            }else {
                self?.didRequestComplete(nil)
            }
            return nil
        }, error: errorBlockFunc())
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VoiceQuestionCell.className()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = dataSource?[indexPath.row] as? QuestionModel{
            return  model.cellHeight
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        if action == 100{
            if let vc = storyboard?.instantiateViewController(withIdentifier: VoiceAnswerVC.className()) as? VoiceAnswerVC,
                let model = data as? QuestionModel{
                vc.model = model
                vc.complete = { [weak self](response) in
                    self?.didRequest(1)
                    return nil
                }
                _ = navigationController?.pushViewController(vc, animated: true)
            }
        }
        if action == 101{
            if let question = data as? QuestionModel,
               let cell = tableView.cellForRow(at: indexPath) as? VoiceQuestionCell{
                voiceBtn.setImage(UIImage.init(named: "voice_4"), for: .normal)
                let urlStr = qiniuHelper.shared().qiniuHeader + question.sanswer
                VoicePlayerHelper.shared().play(urlStr)
                voiceBtn = cell.voiceBtn
            }
        }
    }
}
