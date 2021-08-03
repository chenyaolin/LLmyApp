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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        chartsView.addSubview(lineChartView)
        lineChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
//        xAxis.drawAxisLineEnabled = false
//        xAxis.drawLabelsEnabled = false
        
        let yAxis = lineChartView.leftAxis
        
        lineChartView.rightAxis.enabled = false
        
        var entries = [ChartDataEntry]()
        for i in 0...10 {
            let entry = ChartDataEntry(x: Double(i), y: Double(arc4random_uniform(50)))
            entries.append(entry)
        }
        var entries1 = [ChartDataEntry]()
        for i in 0...10 {
            let entry = ChartDataEntry(x: Double(i), y: Double(arc4random_uniform(50)))
            entries1.append(entry)
        }

        let set = LineChartDataSet(entries: entries, label: "")
        let set1 = LineChartDataSet(entries: entries1, label: "")
        
        set.mode = .linear
        set.drawCirclesEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = false
        
        set1.mode = .linear
        set1.drawCirclesEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
//        set.fillColor = .yellow
        
        let data = LineChartData(dataSets: [set, set1])
        
        lineChartView.data = data
        
    }
    
}
