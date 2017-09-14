//
//  qiniuHelper.swift
//  iOSStar
//
//  Created by mu on 2017/8/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Alamofire
import Qiniu

class qiniuHelper: NSObject {
    static let helper = qiniuHelper()
    class func shared() -> qiniuHelper{
        return helper
    }
    var qiniuHeader = "http://ouim6qew1.bkt.clouddn.com/"
    var netInfo = NetModel()
    
    func getIPAdrees() {
        Alamofire.request(AppConst.ipUrl).responseString { (response) in
            if let value = response.result.value {
                if let ipValue = value.components(separatedBy: ",").first{
                    print(ipValue)
                    let ipString = (ipValue as NSString).substring(with: NSRange.init(location: 5, length: ipValue.length() - 6))
                    self.getIPInfoAdrees(ipString)
                }
            }
        }
    }
    
    func getIPInfoAdrees(_ ipString: String) {
        let url = "\(AppConst.ipInfoUrl)\(ipString)"
        Alamofire.request(url).responseJSON { (response) in
            if let value = response.result.value as? NSDictionary{
                if let dataDic = value.value(forKey: "data") as? NSDictionary{
                    if let area = dataDic.value(forKey: "area") as? String{
                        self.netInfo.area = area
                        self.getQiniuHeader(area)
                    }
                    if let areaId = dataDic.value(forKey: "area_id") as? NSString{
                        self.netInfo.area_id = Int((areaId).intValue)
                    }
                    if let isp = dataDic.value(forKey: "isp") as? String{
                        self.netInfo.isp = isp
                    }
                    if let isp_id = dataDic.value(forKey: "isp_id") as? NSString{
                        self.netInfo.isp_id = Int((isp_id).intValue)
                    }
                    
                    
                }
            }
        }
    }
    
    func getQiniuHeader(_ area: String) {
        AppAPIHelper.commen().qiniuHttpHeader(complete: { (result) in
            if let model = result as? QinniuModel{
                if area == "华南"{
                    self.qiniuHeader = model.QINIU_URL_HUANAN
                    return nil
                }
                if area == "华北"{
                    self.qiniuHeader = model.QINIU_URL_HUABEI
                    return nil
                }
                if area == "华东"{
                    self.qiniuHeader = model.QINIU_URL_HUADONG
                    return nil
                }
            }
            return nil
        }, error: nil)
    }
    
    
    //上传视频
    class  func qiniuUploadVideo(filePath: String,videoName: String, complete: CompleteBlock?, error: ErrorBlock?) {
        let timestamp = NSDate().timeIntervalSince1970
        let key = "\(videoName)\(Int(timestamp)).mp4"
        uploadResource(filePath: filePath, key: key, complete: complete, error: error)
    }
    
    //上传声音
    class  func qiniuUploadVoice(filePath: String,voiceName: String, complete: CompleteBlock?, error: ErrorBlock?) {
        let timestamp = NSDate().timeIntervalSince1970
        let key = "\(voiceName)\(Int(timestamp)).mp3"
        uploadResource(filePath: filePath, key: key, complete: complete, error: error)
    }
    
    class  func uploadResource(filePath : String, key : String, complete: CompleteBlock?, error: ErrorBlock?){
        AppAPIHelper.commen().uploadimg(complete: { (result) in
            if   let response = result as? UploadTokenModel{
                let qiniuManager = QNUploadManager()
                qiniuManager?.putFile(filePath, key: key, token: response.uptoken, complete: {  (info, key, resp) in
                    if complete == nil{
                        return
                    }
                    if resp == nil {
                        complete!(nil)
                        return
                    }
                    //3,返回URL
                    let respDic: NSDictionary? = resp as NSDictionary?
                    let value:String? = respDic!.value(forKey: "key") as? String
                    let imageUrl = value!
                    complete!(imageUrl as AnyObject?)
                    
                }, option: nil)
            }
            return nil
        }) { (error ) in
            return nil
        }
    }
}

class NetModel: BaseModel {
    var isp = ""
    var area = ""
    var isp_id = 0
    var area_id = 0
}

class QinniuModel: BaseModel{
    var QINIU_URL_HUADONG = ""
    var QINIU_URL_HUABEI = ""
    var QINIU_URL_HUANAN = ""
}

