//
//  GraphReactTimeView.swift
//  MHacksViews
//
//  Created by Shreyan Jain on 9/12/15.
//  Copyright (c) 2015 Shreyan Jain. All rights reserved.
//

import UIKit

class GraphReactTimeView: UIView {
    var plotValues: [Double]!
    var xLabels: [String]!
    var count: Int!
    
    let startColor: UIColor = UIColor(red: 149.0/255.0, green: 248.0/255.0, blue:255.0/255.0, alpha: 1.0);
    let endColor: UIColor = UIColor(red: 22.0/255.0, green: 201.0/255.0, blue:255.0/255.0, alpha: 1.0);
    
    init(values:[Double], labels:[String], count:Int, frame:CGRect) {
        plotValues = values;
        xLabels = labels
        self.count = count
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        //2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 - set up the color stops
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        //5 - create the gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
            colors,
            colorLocations)
        
        //6 - draw the gradient
        var startPoint = CGPoint.zeroPoint
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context,
            gradient,
            startPoint,
            endPoint,
            0)
        
        let margin:CGFloat = 20;
        var columnXPoint = { (column:Int) -> CGFloat in
            //Calculate gap between points
            let spacer = (width - margin*2 - 4) /
                CGFloat((self.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder:CGFloat = 20
        let bottomBorder:CGFloat = 10
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = maxElement(plotValues)
        let minValue = minElement(plotValues)
        var min = 0.0;
        if (2*minValue - maxValue > 0) {
            min = 2*minValue - maxValue
        }
        var columnYPoint = { (graphPoint:Double) -> CGFloat in
            var y:CGFloat = (CGFloat(graphPoint) - CGFloat(min)) /
                (CGFloat(maxValue) - CGFloat(min)) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        
        // draw the line graph
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        //set up the points line
        var graphPath = UIBezierPath()
        //go to start of line
        graphPath.moveToPoint(CGPointMake(columnXPoint(0),
            columnYPoint(plotValues[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<plotValues.count {
            let nextPoint = CGPointMake(columnXPoint(i),
                columnYPoint(plotValues[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        //1 - save the state of the context
        CGContextSaveGState(context)
        
        //2 - make a copy of the path
        var clippingPath = graphPath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLineToPoint(CGPoint(
            x: columnXPoint(plotValues.count - 1),
            y:height))
        clippingPath.addLineToPoint(CGPoint(
            x:columnXPoint(0),
            y:height))
        clippingPath.closePath()
        
        //4 - add the clipping path to the context
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        for i in 0..<plotValues.count {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(plotValues[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        var linePath = UIBezierPath()
        
        //top line
        linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin,
            y:topBorder))
        
        //center line
        linePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:graphHeight/2 + topBorder))
        
        //bottom line
        linePath.moveToPoint(CGPoint(x:margin,
            y:height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }
}
