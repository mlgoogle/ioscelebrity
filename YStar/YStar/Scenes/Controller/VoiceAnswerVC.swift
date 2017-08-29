//
//  VoiceAnswerVC.swift
//  YStar
//
//  Created by mu on 2017/8/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import AVFoundation
class VoiceAnswerVC: BaseTableViewController {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var rerecordBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var voiceIconimage: UIImageView!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var voiceLengthLabel: UILabel!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var voiceIndirectorView: UIView!
    @IBOutlet weak var subTimeLabel: UILabel!
    var recordTime: Int = 0
    var timer: Timer?
    var model: QuestionModel = QuestionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRecordBtn()
        initUI()
    }
    
    func initUI() {
        iconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        let cancelImage = UIImage.imageWith("\u{e627}", fontSize: CGSize.init(width: 30, height: 30), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.label9.rawValue))
        rerecordBtn.setImage(cancelImage, for: .normal)
        let playImage = UIImage.imageWith("\u{e672}", fontSize: CGSize.init(width: 30, height: 30), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.label9.rawValue))
        playBtn.setImage(playImage, for: .normal)
        voiceIconimage.image = UIImage.imageWith("\u{e669}", fontSize: CGSize.init(width: 30, height: 44), fontColor: UIColor.white)
        let recordImage = UIImage.imageWith("\u{e669}", fontSize: CGSize.init(width: 30, height: 30), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue))
        recordBtn.setImage(recordImage, for: .normal)
        
        iconImage.kf.setImage(with: URL.init(string: model.headUrl))
        nameLabel.text =  model.nickName
        timeLabel.text = "定制  \(Date.yt_convertDateStrWithTimestemp(model.ask_t, format: "yyyy-MM-dd"))"
        subTimeLabel.text = "\((model.c_type + 1)*15)S"
        contentLabel.text = model.uask
    }
    
    func initRecordBtn() {
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(recordBtnlongTapped(_:)))
        recordBtn.addGestureRecognizer(gesture)
    }
    
    func recordBtnlongTapped(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began{
            print("<<<<<<<<<<<<<<<<<<<<<<<<<")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(recordTimeBegin), userInfo: nil, repeats: true)
            recordTime = 0
            voiceIndirectorView.alpha = 0.5
            voiceLengthLabel.text = "0秒"
            VoicePlayerHelper.shared().startRecord()
        }
        
        if gesture.state == .ended {
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>")
            timer?.invalidate()
            voiceIndirectorView.alpha = 0
            playView.alpha = 1
            playBtn.setTitle("  \(recordTime)S     点击播放", for: .normal)
            VoicePlayerHelper.shared().stopRecord()
        }
    }
    
    func recordTimeBegin() {
        recordTime = recordTime + 1
        print(recordTime)
        voiceLengthLabel.text = "\(recordTime)秒"
    }
 
    @IBAction func rerecordBtnTapped(_ sender: UIButton) {
        playView.alpha = 0
        playBtn.setTitle("  0S     点击播放", for: .normal)
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
         VoicePlayerHelper.shared().startPlaying()
    }
    
    @IBAction func didCommit(_ sender: UIBarButtonItem) {
        VoicePlayerHelper.shared().uploadURL(complete: { [weak self] url in
            let param = AnswerRequestModel()
            param.id  = self?.model.id ?? 0
            param.sanswer = url as! String
            AppAPIHelper.commen().starAnswer(requestModel: param, complete: { (response) -> ()? in
                if let result = response as? ResultModel{
                    if result.result == 0{
                        _ = self?.navigationController?.popViewController(animated: true)
                    }
                }
                return nil
            }, error: self?.errorBlockFunc())
            return nil
        }, error: { error in
            return nil
        })
    }
    
}

