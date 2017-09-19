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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var recordIndex = 0
    
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
        var activityGroups = ChartDataGenerator.data(recordIndex: recordIndex)
        
        // Initialize an array to store chart data entries (values; y axis)
        var agEntries = [ChartDataEntry]()
        
        // Initialize an array to store months (labels; x axis)
        var agDates = [String]()
        
        var i = 0
        for ag in activityGroups {
            // Create single chart data entry and append it to the array
//            let entry = ChartDataEntry()
            
            let agEntry = BarChartDataEntry(x: Double(i), y: Double(ag.value))
            agEntries.append(agEntry)
            
            // Append the month to the array
            agDates.append(ag.date)
            
            i += 1
        }
        
        
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(values: agEntries, label: "Records")
        
        // Create bar chart data with data set and array with values for x axis
      
        let chartData = BarChartData(dataSets: [chartDataSet])
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: agDates)
        
        
        // Set bar chart data to previously created data
        barChart.data = chartData
        barChart.notifyDataSetChanged()
        
        barChart.xAxis.labelPosition = .bottom
//
        chartDataSet.colors = [.red, .yellow, .green]
        chartDataSet.colors = ChartColorTemplates.joyful()
//

        barChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
    }

}
