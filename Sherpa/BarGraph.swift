//
//  BarGraph.swift
//  autism
//
//  Created by Praynaa Rawlani on 9/13/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import PNChartSwift

class BarGraph: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame:CGRect) {
        super.init(frame: frame)
        makeGraph();
    }
    
    func makeGraph() {
        var ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        ChartLabel.textColor = PNGreenColor
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.text = "Reaction Time Data over time"
        ChartLabel.textAlignment = NSTextAlignment.Center
        
        var barChart = PNBarChart(frame: CGRectMake(0, 135.0, 320.0, 200.0))
        barChart.backgroundColor = UIColor.clearColor()
        //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
        //                var yValueParsed:CGFloat = yValue
        //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
        //                return labelText;
        //            })
        
        
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Waterfall
        
        
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        barChart.yValues = [2.9,2.4,3.3,1.8,3.0,2.7,3.7]
        barChart.strokeChart()
        
        self.addSubview(ChartLabel)
        self.addSubview(barChart)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
