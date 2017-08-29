//
//  VoicePlayerHelper.swift
//  YStar
//
//  Created by mu on 2017/8/29.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import Foundation
import AVFoundation

class VoicePlayerHelper: NSObject, PLPlayerDelegate{
    
    static var vPlayer = VoicePlayerHelper()
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0) as Float),//声音采样率
        AVFormatIDKey : NSNumber(value: Int32(kAudioFormatLinearPCM) as Int32),//编码格式
        AVNumberOfChannelsKey : NSNumber(value: 2 as Int32),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue) as Int32)]//音频质量
    
    lazy var player: PLPlayer = {
        let option = PLPlayerOption.default()
        let player = PLPlayer.init(url: nil, option: option)
        player?.delegate = vPlayer
        return player!
    }()
    
    class func shared() -> VoicePlayerHelper {
        return vPlayer
    }
    
    func  initRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(url: directoryURL()!,
                                                settings: recordSettings)//初始化实例
            audioRecorder.prepareToRecord()//准备录音
        } catch {
        }
    }
    
    func directoryURL() -> URL? {
        //定义并构建一个url来保存音频，音频文件名为ddMMyyyyHHmmss.caf
        //根据时间来设置存储文件名
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let recordingName = formatter.string(from: currentDateTime)+".caf"
        print(recordingName)
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as URL
        let soundURL = documentDirectory.appendingPathComponent(recordingName)
        return soundURL
    }
    
    func startRecord() {
        //开始录音
        if !audioRecorder.isRecording {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                print("record!")
            } catch {
            }
        }
    }
    
    func stopRecord() {
        //停止录音
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(false)
            print("stop!!")
        } catch {
        }
    }
    
    func startPlaying() {
        //开始播放
        if (!audioRecorder.isRecording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
                audioPlayer.play()
                print("play!!")
            } catch {
            }
        }
    }
    
    func play(_ urlStr: String){
        do {
            if let url = URL.init(string: urlStr){
                print(url)
//                let voiceItem = AVPlayerItem.init(url: url)
//                let avPlayer = AVPlayer.init(playerItem: voiceItem)
//                avPlayer.play()
                print("play!!")
                player.play(with: url)
                player.play()
            }
        } catch {
            print("播放失败")
        }
    }
    
    func pausePlaying() {
        //暂停播放
        if (!audioRecorder.isRecording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
                audioPlayer.pause()
                
                print("pause!!")
            } catch {
            }
        }
        
    }
    
    func uploadURL(complete: @escaping CompleteBlock, error: @escaping ErrorBlock) {
        let path = lameToMp3.caf(toMP3: audioRecorder.url.relativePath) ?? ""
        qiniuHelper.qiniuUploadVoice(filePath: path, voiceName: "voice", complete: { (response) in
            if let urlStr = response as? String{
                complete(urlStr as AnyObject?)
            }
            return nil
        }, error: error)
    }
}
