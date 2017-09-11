//
//  VoiceAnswerVC.swift
//  YStar
//
//  Created by mu on 2017/8/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD

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
    @IBOutlet weak var openSwitch: UISwitch!
    @IBOutlet weak var voiceTitleLabel: UILabel!
    var complete: CompleteBlock?
    var recordTime: Int = 0
    var totalTime: Int = 0
    var timer: Timer?
    var model: QuestionModel = QuestionModel()
    var isCancel = false
    var cancelImage = UIImage.imageWith("\u{e66d}", fontSize: CGSize.init(width: 44, height: 44), fontColor: UIColor.white)
    var recordImage = UIImage.imageWith("\u{e669}", fontSize: CGSize.init(width: 44, height: 44), fontColor: UIColor.white)
    
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
        voiceIconimage.image = UIImage.imageWith("\u{e669}", fontSize: CGSize.init(width: 44, height: 44), fontColor: UIColor.white)
        let recordImage = UIImage.imageWith("\u{e669}", fontSize: CGSize.init(width: 30, height: 30), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue))
        recordBtn.setImage(recordImage, for: .normal)
        iconImage.kf.setImage(with: URL.init(string: model.headUrl))
        nameLabel.text =  model.nickName
        timeLabel.text = "定制  \(Date.yt_convertDateStrWithTimestemp(model.ask_t, format: "yyyy-MM-dd"))"
        totalTime = (model.c_type + 1)*15
        subTimeLabel.text = "\(totalTime)S"
        contentLabel.text = model.uask
        tableView.isScrollEnabled = false
    }
    
    func initRecordBtn() {
        let tapGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(recordBtnlongTapped(_:)))
        recordBtn.addGestureRecognizer(tapGesture)
    }
    
    func recordBtnlongTapped(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(recordTimeBegin), userInfo: nil, repeats: true)
            recordTime = 0
            voiceIndirectorView.alpha = 0.5
            voiceLengthLabel.text = "0秒"
            playView.alpha = 0
            VoicePlayerHelper.shared().startRecord()
            return
        }
        
        if gesture.state == .ended {
            endRecord()
            return
        }
        
        if gesture.state == .failed{
        }
        
        let point = gesture.location(in: recordBtn)
        if point.y < -20{
            voiceIconimage.image = cancelImage
            voiceTitleLabel.text = "松开手指取消录制"
            isCancel = true
        }else{
            voiceIconimage.image = recordImage
            voiceTitleLabel.text = "手指上滑取消录制"
            isCancel = false
        }
    }
    
    func endRecord() {
        timer?.invalidate()
        if isCancel{
            voiceIndirectorView.alpha = 0
            playView.alpha = 0
            recordTime = 0
            return
        }
        voiceIndirectorView.alpha = 0
        playView.alpha = 1
        playBtn.setTitle("  \(recordTime)S     点击播放", for: .normal)
        VoicePlayerHelper.shared().stopRecord()
    }
    
    func recordTimeBegin() {
        recordTime = recordTime + 1
        print(recordTime)
        voiceLengthLabel.text = "\(recordTime)秒"
        if totalTime == recordTime{
            endRecord()
        }
    }
 
    @IBAction func rerecordBtnTapped(_ sender: UIButton) {
        playView.alpha = 0
        playBtn.setTitle("  0S     点击播放", for: .normal)
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
         VoicePlayerHelper.shared().startPlaying()
    }
    
    @IBAction func didCommit(_ sender: UIBarButtonItem) {
        if isCancel || recordTime == 0{
            SVProgressHUD.showWainningMessage(WainningMessage: "请录制音频", ForDuration: 2, completion: nil)
            return
        }
        
        VoicePlayerHelper.shared().uploadURL(complete: { [weak self] url in
            let param = AnswerRequestModel()
            param.id  = self?.model.id ?? 0
            param.sanswer = url as! String
            param.pType = (self?.openSwitch.isOn)! ? 1 : 0
            SVProgressHUD.showProgressMessage(ProgressMessage: "回复中...")
            AppAPIHelper.commen().starAnswer(requestModel: param, complete: { (response) -> ()? in
                SVProgressHUD.dismiss()
                if let result = response as? ResultModel{
                    if result.result == 0{
                        if self?.complete != nil{
                            self?.complete!(1 as AnyObject)
                        }
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "回复成功", ForDuration: 1.5, completion: nil)
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

