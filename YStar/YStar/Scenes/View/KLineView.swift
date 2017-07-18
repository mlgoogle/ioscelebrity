//
//  KLineView.swift
//  YStar
//
//  Created by mu on 2017/7/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Charts
class KLineView: LineChartView, ChartViewDelegate, UIScrollViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
