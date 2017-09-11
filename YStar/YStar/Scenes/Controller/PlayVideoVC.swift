//
//  PlayVideoVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class PlayVideoVC: UIViewController {

    @IBOutlet weak var qBgView: UIView!
    @IBOutlet weak var qIconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qContentLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var hiddleBtn: UIButton!
    @IBOutlet weak var progressCons: NSLayoutConstraint!
    @IBOutlet weak var playImage: UIImageView!
    var bgImageUrl = ""
    var question = QuestionModel()
    var timer: Timer?
    lazy var player: PLPlayer = {
        let option = PLPlayerOption.default()
        let player = PLPlayer.init(url: nil, option: option)
        return player!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        if let playView = player.playerView{
            view.addSubview(playView)
            view.sendSubview(toBack: playView)
        }
        let iconImage = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        qIconImage.kf.setImage(with: URL.init(string: question.headUrl), placeholder: iconImage)
        nameLabel.text = question.nickName
        qContentLabel.text = question.uask
        let image = UIImage.imageWith("\u{e63e}", fontSize: CGSize.init(width: 25, height: 25), fontColor: UIColor.white)
        closeBtn.setImage(image, for: .normal)
        playImage.kf.setImage(with: URL.init(string: qiniuHelper.shared().qiniuHeader + bgImageUrl))
        
        let hiddleImage = UIImage.imageWith("\u{e673}", fontSize: CGSize.init(width: 25, height: 25), fontColor: UIColor.white)
        hiddleBtn.setImage(hiddleImage, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkPlayStatus), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    

    @IBAction func askQustion(_ sender: Any) {
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismissController()
    }
    
    @IBAction func hiddleBtnTapped(_ sender: UIButton) {
        hiddleQustion(sender.isSelected)
        sender.isSelected = !sender.isSelected
    }
    
    func hiddleQustion(_ isHiddle: Bool){
        qBgView.isHidden = isHiddle
        qIconImage.isHidden = isHiddle
        nameLabel.isHidden = isHiddle
        qContentLabel.isHidden = isHiddle
    }
    
    func play(_ urlStr: String) {
        player.play(with: URL.init(string: urlStr))
    }
    
    func checkPlayStatus(){
        if player.totalDuration.value  == 0{
            return
        }
        let current = CGFloat(player.currentTime.value)/CGFloat(player.currentTime.timescale)
        let total = CGFloat(player.totalDuration.value)/CGFloat(player.totalDuration.timescale)
        progressCons.constant = qBgView.frame.width * current/total
    }
}

extension PlayVideoVC: PLPlayerDelegate{
    
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        switch state {
        case .statusPreparing:
            SVProgressHUD.showProgressMessage(ProgressMessage: "加载中...")
        case .statusCaching:
            SVProgressHUD.showProgressMessage(ProgressMessage: "加载中...")
        case .statusPlaying:
            view.sendSubview(toBack: playImage)
            SVProgressHUD.dismiss()
        case .stateAutoReconnecting:
            SVProgressHUD.showProgressMessage(ProgressMessage: "重连...")
        case .statusError:
            SVProgressHUD.showErrorMessage(ErrorMessage: "播放异常", ForDuration: 1, completion: { [weak self] (message) in
                self?.dismissController()
            })
        default:
            return
        }
    }
    
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        
    }
    
    func player(_ player: PLPlayer, codecError error: Error) {
        SVProgressHUD.showErrorMessage(ErrorMessage: "网络异常", ForDuration: 1, completion: nil)
    }
}
