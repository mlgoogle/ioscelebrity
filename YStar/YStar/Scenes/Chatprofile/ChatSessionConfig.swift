//
//  ChatSessionConfig.swift
//  YStar
//
//  Created by MONSTER on 2017/7/21.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ChatSessionConfig: NSObject,NIMSessionConfig {
    
    func mediaItems() -> [NIMMediaItem]! {
        return NIMKitUIConfig.shared().defaultMediaItems() as! [NIMMediaItem]
    }
    
    func disableCharlet() -> Bool {
        return true
    }
}
