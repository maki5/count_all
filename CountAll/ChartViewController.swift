//
//  ChartViewController.swift
//  CountIt
//
//  Created by maki on 9/19/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChart()
        self.title = vcTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var recordIndex = 0
    var vcTitle = ""
    
    @IBOutlet var barChart: BarChartView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setupChart() {
        let activityGroups = ChartDataGenerator.data(recordIndex: recordIndex)
        
        
        var agEntries = [ChartDataEntry]()
        var agDates = [String]()
        
        var i = 0
        for ag in activityGroups {
            let agEntry = BarChartDataEntry(x: Double(i), y: Double(ag.value))
            agEntries.append(agEntry)
            
            agDates.append(ag.date)
            
            i += 1
        }
        
        
        let chartDataSet = BarChartDataSet(values: agEntries, label: "Records")
        
        
        let chartData = BarChartData(dataSets: [chartDataSet])
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: agDates)
        
        
        barChart.data = chartData
        barChart.notifyDataSetChanged()
        
        barChart.xAxis.labelPosition = .bottom
        barChart.chartDescription?.text = ""
        barChart.xAxis.drawLabelsEnabled = true
        barChart.legend.enabled = false
        
        chartDataSet.colors = [.red, .yellow, .green]
        chartDataSet.colors = ChartColorTemplates.joyful()


        barChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
    }

}
