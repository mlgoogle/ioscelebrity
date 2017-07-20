//
//  KLineView.swift
//  YStar
//
//  Created by mu on 2017/7/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Charts

class MarkerLineView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgbHex: 0xFB9938)
        view.alpha = 0.8
        return view
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backView.frame = frame
        titleLabel.frame = CGRect.init(x: 2, y: 2, width: frame.size.width-4, height: frame.size.height-4)
        addSubview(backView)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class KLineView: LineChartView, ChartViewDelegate, UIScrollViewDelegate {
    private var chartData: [EarningInfoModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initKlineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initKlineView()
    }
    
    func initKlineView() {
        self.legend.setCustom(entries: [])
        self.noDataText = "暂无数据"
        self.doubleTapToZoomEnabled = false
        self.xAxis.labelPosition = .bottom
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.labelFont = UIFont.systemFont(ofSize: 0)
        self.leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        self.leftAxis.labelTextColor = UIColor.init(rgbHex: 0xFB9938)
        self.leftAxis.gridColor = UIColor.init(rgbHex: 0xe5e5e5)
        self.leftAxis.gridLineDashLengths = [3,3]
        self.leftAxis.gridColor = UIColor.init(rgbHex: 0xe5e5e5)
        self.rightAxis.enabled = false
        self.delegate = self
        self.chartDescription?.text = ""
        self.drawBordersEnabled = false
        self.borderLineWidth = 0.5
        self.animate(xAxisDuration: 1)
    }
    
    //刷新折线
    func refreshLineChartData(models: [EarningInfoModel]) {
        chartData = models
        var entrys: [ChartDataEntry] = []
        for (i, model) in models.enumerated()  {
            let entry = ChartDataEntry.init(x: Double(i), y: Double(model.order_count))

            entrys.append(entry)
        }
        let set: LineChartDataSet = LineChartDataSet.init(values: entrys, label: "折线图")
        set.colors = [UIColor.init(rgbHex: 0xfb9938)]
        set.circleRadius = 5
        set.setCircleColor(UIColor.init(rgbHex: 0xfb9938))
        set.circleHoleRadius = 0
        set.mode = .linear
        set.valueFont = UIFont.systemFont(ofSize: 0)
        let data: LineChartData  = LineChartData.init(dataSets: [set])
        self.data = data
        self.xAxis.axisMaximum = Double(entrys.count)
    }
    
    //Mark: --delegate
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
       
        let index =  Int(entry.x)
        if index >= 0 && index < chartData.count {
            if let model: EarningInfoModel = chartData[index]{

                let markerView = MarkerLineView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 44))
                
                markerView.titleLabel.text = markerLineText(model: model)
                let marker = MarkerImage.init()
                marker.chartView = chartView
                marker.image = UIImage.imageFromUIView(markerView)
                chartView.marker = marker
            }
        }
    }
    func markerLineText(model: EarningInfoModel) -> String {
        return "\(model.orderdate)\n交易数量\(model.order_count)"
    }
}
