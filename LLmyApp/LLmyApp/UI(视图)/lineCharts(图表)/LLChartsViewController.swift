//
//  LLChartsViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/8/3.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit
import Charts

class LLChartsViewController: UIViewController {
    
    
    @IBOutlet weak var chartsView: UIView!
    
    private lazy var lineChartView = LineChartView()
    
    private lazy var customMarkView: LLMarkView = {
        let view = LLMarkView(frame: CGRect(x: 0, y: 0, width: 90, height: 120))
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        chartsView.addSubview(lineChartView)
        lineChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lineChartView.delegate = self
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false // 不显示图例描述
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottomInside
        xAxis.drawGridLinesEnabled = false
//        xAxis.drawAxisLineEnabled = false
//        xAxis.drawLabelsEnabled = false
        xAxis.axisLineWidth = 1
        xAxis.spaceMin = 1
        
        // 自定义x轴的显示
//        xAxis.valueFormatter = CustomValueFormatter()
        /// 左边轴线颜色
        xAxis.axisLineColor = .white
        /// 左边轴线文字颜色
        xAxis.labelTextColor = .white
        
        let lfAxis = lineChartView.leftAxis
        // 左边轴显示是不线内还是线外
        lfAxis.labelPosition = .insideChart
        // 自定义x轴的显示
//        lfAxis.valueFormatter = CustomValueFormatter()
        // 距离顶部距离(但仍然有10个像素)
        lfAxis.spaceTop = 0
        /// 左边轴线颜色
        lfAxis.axisLineColor = .white
        /// 左边轴线文字颜色
        lfAxis.labelTextColor = .white
        /// y轴辅助线
        lfAxis.drawGridLinesEnabled = false
        
        lineChartView.rightAxis.enabled = false
        
        var entries = [ChartDataEntry]()
        for i in 0...10 {
            let entry = ChartDataEntry(x: Double(i), y: Double(i*8))
            entries.append(entry)
        }
        var entries1 = [ChartDataEntry]()
        for i in 0...10 {
            let entry = ChartDataEntry(x: Double(i), y: Double(i*10))
            entries1.append(entry)
        }

        let set = LineChartDataSet(entries: entries, label: "")
        let set1 = LineChartDataSet(entries: entries1, label: "")
        
        // 不显示具体数值
        set.drawValuesEnabled = false
        // 硬线模式
        set.mode = .linear
        // 数值是否显示圆点
        set.drawCirclesEnabled = false
        // 取消高亮横向辅助线
        set.drawHorizontalHighlightIndicatorEnabled = false
        /// 设置折线颜色
        set.setColor(.red, alpha: 1)
        /// 高亮线颜色
        set.highlightColor = .white
        
        set1.drawValuesEnabled = false
        set1.mode = .linear
        // 数值是否显示圆点
        set1.drawCirclesEnabled = false
        // 取消高亮横向辅助线
        set1.drawHorizontalHighlightIndicatorEnabled = false
        /// 设置折线颜色
        set1.setColor(.orange, alpha: 1)
        /// 高亮线颜色
        set1.highlightColor = .white
        
//        let data = LineChartData(dataSets: [set])
        let data = LineChartData(dataSets: [set, set1])
        lineChartView.data = data
        
        lineChartView.drawMarkers = true
        let makerView = MarkerView()
        makerView.offset = CGPoint(x: -customMarkView.frame.size.width/2, y: -customMarkView.frame.size.height)
        makerView.chartView = lineChartView
        lineChartView.marker = makerView
        makerView.addSubview(customMarkView)
        
//        let makerView1 = MarkerView()
//        makerView1.offset = CGPoint(x: -customMarkView.frame.size.width/2, y: -customMarkView.frame.size.height)
//        makerView1.chartView = lineChartView
//        lineChartView.marker = makerView1
//        makerView1.addSubview(customMarkView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("111111 \(self.lineChartView.extraTopOffset)")
    }
    
}

extension LLChartsViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("111111 chartValueSelected \(entry.y) - \(highlight.yPx) - \(highlight.axis.rawValue)")
        let value = chartView.highlighted
        for item in value {
            print("111111 chartValueSelected \(item.y)")
        }
        customMarkView.setMarkerView(withY: CGFloat(entry.y), xPy: highlight.yPx, x: CGFloat(entry.x))
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("111111 chartValueNothingSelected")
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        print("111111 chartViewDidEndPanning")
    }
    
}

/// 自定义x轴的显示
class CustomValueFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "2.1"
    }
}

class YourMarkerView: MarkerView {
    var textLayer: CATextLayer = {
        let tempLayer = CATextLayer()
        tempLayer.backgroundColor = UIColor.clear.cgColor
        tempLayer.fontSize = 12
        tempLayer.alignmentMode = .center
        tempLayer.foregroundColor = UIColor.black.cgColor
        return tempLayer
    }()
    
    var mOffset: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = [self.frame.size.width, self.frame.size.height].min()! / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(white: 150.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        
        self.layer.addSublayer(self.textLayer)
        self.textLayer.frame = CGRect(x: 0, y: (self.frame.size.height - 16)/2, width: self.frame.size.width, height: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        
        self.textLayer.string = String(entry.y)
    }
    
    override var offset: CGPoint {
        get {
            if(self.mOffset == nil) {
               // center the marker horizontally and vertically
                self.mOffset = CGPoint(x: -(self.bounds.size.width / 2), y: -self.bounds.size.height)
            }
            
            return self.mOffset!
        }
        set {
            
        }
    }
}
