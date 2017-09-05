//
//  VideoAnswerVC.swift
//  YStar
//
//  Created by mu on 2017/8/31.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD

class VideoAnswerVC: BaseTableViewController {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var rerecordBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var questionBtn: UIButton!
    @IBOutlet weak var playView: UIImageView!
    @IBOutlet weak var videoIndirectorView: UIView!
    @IBOutlet weak var subTimeLabel: UILabel!
    @IBOutlet weak var openSwitch: UISwitch!
    @IBOutlet weak var videoTitleLabel: UILabel!
    var complete: CompleteBlock?
    var recordTime: Int = 0
    var totalTime: Int = 0
    var timer: Timer?
    var model: QuestionModel = QuestionModel()
    var videoModel = VideoModel()
    var isCancel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        iconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        let cancelImage = UIImage.imageWith("\u{e627}", fontSize: CGSize.init(width: 30, height: 30), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.label9.rawValue))
        rerecordBtn.setImage(cancelImage, for: .normal)
        let playImage = UIImage.imageWith("\u{e66f}", fontSize: CGSize.init(width: 40, height: 40), fontColor: UIColor.white)
        playBtn.setImage(playImage, for: .normal)
        let recordImage = UIImage.imageWith("\u{e66c}", fontSize: CGSize.init(width: 30, height: 30), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.subMain.rawValue))
        recordBtn.setImage(recordImage, for: .normal)
        iconImage.kf.setImage(with: URL.init(string: model.headUrl))
        nameLabel.text =  model.nickName
        timeLabel.text = "定制  \(Date.yt_convertDateStrWithTimestemp(model.ask_t, format: "yyyy-MM-dd"))"
        totalTime = (model.c_type + 1)*15
        subTimeLabel.text = "\(totalTime)S"
        contentLabel.text = model.uask
    }
    
    @IBAction func checkQuestion(_ sender: UIButton) {
        if model.video_url.length() == 0 {
            SVProgressHUD.showWainningMessage(WainningMessage: "没有提问视频", ForDuration: 1, completion: nil)
            return
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: PlayVideoVC.className()) as? PlayVideoVC{
            vc.question = model
            vc.bgImageUrl = model.thumbnail
            present(vc, animated: true, completion: nil)
            if model.video_url.hasPrefix("http"){
                
                vc.play(model.video_url)
            }else{
                vc.play(qiniuHelper.helper.qiniuHeader + model.video_url)
            }
        }
    }
    
    @IBAction func rerecordBtnTapped(_ sender: UIButton) {
        isCancel = true
        videoIndirectorView.alpha = 0
    }

    @IBAction func playBtnTapped(_ sender: UIButton) {
        isCancel = false
        if let vc = storyboard?.instantiateViewController(withIdentifier: PlayVideoVC.className()) as? PlayVideoVC{
            vc.question = model
            vc.bgImageUrl = self.videoModel.iconUrl
            present(vc, animated: true, completion: nil)
            vc.play(qiniuHelper.helper.qiniuHeader + videoModel.movieUrl)
        }
    }
    
    @IBAction func submitItemTapped(_ sender: UIBarButtonItem) {
        if isCancel || videoModel.movieUrl.length() == 0{
            SVProgressHUD.showWainningMessage(WainningMessage: "请录制视频", ForDuration: 2, completion: nil)
            return
        }
        let param = AnswerRequestModel()
        param.id  = model.id
        param.sanswer = videoModel.movieUrl
        param.pType = openSwitch.isOn ? 1 : 0
        param.thumbnailS = videoModel.iconUrl
        AppAPIHelper.commen().starAnswer(requestModel: param, complete: {[weak self] (response) -> ()? in
            if let result = response as? ResultModel{
                if result.result == 0{
                    _ = self?.navigationController?.popViewController(animated: true)
                    if self?.complete != nil{
                        self?.complete!(1 as AnyObject)
                    }
                }
            }
            return nil
        }, error:errorBlockFunc())
    }
    
    @IBAction func recordBtnTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: TakeMovieVC.className()) as? TakeMovieVC{
            vc.resultBlock = {  [weak self] (result) in
                if let video =  result as?  VideoModel{
                    self?.videoModel = video
                    self?.videoIndirectorView.alpha = 1
                    self?.playView.image = video.videoIcon
                }
                return nil
            }
            //TakeMovieVC
            vc.question = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
