//
//  Kernel.swift
//  Capstone Project
//  This class contains model for all the kernel functions and data generation
//  Created by Zixuan Zeng on 11/6/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import Foundation
import UIKit

class Kernel {
    
    var rgbCompositeCurvePoints: [Double]!
    var redCurvePoints: [Double]!
    var greenCurvePoints: [Double]!
    var blueCurvePoints: [Double]!
    
    var rgbCompositeCurve: [Float]!
    var redCurve: [Float]!
    var greenCurve: [Float]!
    var blueCurve: [Float]!
    
    func secondDerivative(_ point: [[Double]]) -> [Double]? {
        
        let n = point.count
        if n == 1 { return nil}
        
        var matrix: [[Double]] = Array(repeating: [0,0,0], count: n)
        var result: [Double] = Array(repeating: 0, count: n)
        
        matrix[0][1] = 1
        matrix[0][0] = 0
        matrix[0][2] = 0
        
        for i in 1..<n-1 {
            
            let P1: CGPoint = CGPoint(x: point[i-1][0], y: point[i-1][1])
            let P2: CGPoint = CGPoint(x: point[i][0], y: point[i][1])
            let P3: CGPoint = CGPoint(x: point[i+1][0], y: point[i+1][1])
            
            matrix[i][0]=Double((P2.x-P1.x)/6)
            matrix[i][1]=Double((P3.x-P1.x)/3)
            matrix[i][2]=Double((P3.x-P2.x)/6)
            result[i]=Double((P3.y-P2.y)/(P3.x-P2.x) - (P2.y-P1.y)/(P2.x-P1.x))
        }
        
        // What about result[0] and result[n-1]? Assuming 0 for now (Brad L.)
        result[0] = 0
        result[n-1] = 0
        
        matrix[n-1][1]=1
        // What about matrix[n-1][0] and matrix[n-1][2]? For now, assuming they are 0 (Brad L.)
        matrix[n-1][0]=0
        matrix[n-1][2]=0
        
        // solving pass1 (up->down)
        
        for i in 1..<n {
            
            let k =  matrix[i][0] / matrix[i-1][1]
            matrix[i][1] -= k * matrix[i-1][2]
            matrix[i][0] = 0
            result[i] -= k * result[i-1]
        }
        
        // solving pass2 (down->up)
        
        for i in (0...n-2).reversed() {
            
            let k = matrix[i][2] / matrix[i+1][1]
            matrix[i][1] -= k * matrix[i+1][0]
            matrix[i][2] = 0
            result[i] -= k * result[i+1]
            
        }
        
        var output: [Double] = Array(repeating: 0, count: n)
        
        for i in 0..<n {
            output[i]=result[i] / matrix[i][1]
        }
        
        return output
    }
    
    func splineCurve(_ points: [[Double]]) -> [CGPoint]? {
        
        let sdA = self.secondDerivative(points)!
        
        let n = sdA.count
        
        if n < 1 { return nil}
        
        var sd: [Double] = Array(repeating: 0, count: n)
        
        for i in 0..<n {
            sd[i] =  sdA[i]
        }
        
        var output: [CGPoint] = []//Array(repeating: 0, count: n+1)
        
        for i in 0..<n-1 {
            
            let cur = CGPoint(x: points[i][0], y: points[i][1])
            let next = CGPoint(x: points[i+1][0], y: points[i+1][1])
            
            for x in Int(cur.x)..<Int(next.x) {
                
                let t = Double((CGFloat(x)-cur.x)/(next.x-cur.x))
                
                let a: Double = 1-t
                let b: Double = t
                let h: Double = Double(next.x - cur.x)
                
                let www = ( (a*a*a-a)*sd[i] + (b*b*b-b)*sd[i+1] )
                var y: Double = a * Double(cur.y) + b * Double(next.y) + (h*h/6) * www
                
                if (y > 255.0)
                {
                    y = 255.0;
                }
                else if (y < 0.0)
                {
                    y = 0.0;
                }
                
                let point = CGPoint(x: Double(x), y: y)
                output.append(point)
            }
        }
        
        let last = CGPoint(x: (points.last?[0])!, y: (points.last?[1])!)
        output.append(last)
        
        return output
    }
    
    func getPreparedSplineCurve(point: [Double]) -> [Float]? {
        
        var convertedPoints: [[Double]] = []
        // Convert from (0, 1) to (0, 255).
        
        for i in 0..<point.count/2 {
            
            let x = point[2*i] * 255
            let y = point[2*i+1] * 255
            convertedPoints.append([x,y])
        }
        
        var splinePoints: [CGPoint] = self.splineCurve(convertedPoints)!
        
        let firstSplinePoint: CGPoint = splinePoints.first!
        
        if Int(firstSplinePoint.x) > 0 {
            
            for i in (0...Int(firstSplinePoint.x)).reversed() {
                
                let newCGPoint = CGPoint(x: i, y: 0)
                splinePoints.insert(newCGPoint, at: 0)
                
            }
        }
        
        let lastSplinePoint: CGPoint = splinePoints.last!
        
        if Int(lastSplinePoint.x) < 255 {
            
            for i in Int(lastSplinePoint.x)+1...255 {
                
                let newCGPoint = CGPoint(x: i, y: 255)
                splinePoints.append(newCGPoint)
            }
        }
        
        var preparedSplinePoints: [Float] = []  // Array(repeating:, count: n)
        
        for newPoint in splinePoints {
            
            let origPoint = CGPoint(x: newPoint.x, y: newPoint.x)
            
            var distance: Float = sqrt(Float(pow((origPoint.x - newPoint.x), 2.0) + pow((origPoint.y - newPoint.y), 2.0)))
            
            if (origPoint.y > newPoint.y){
                
                distance = -distance;
            }
            
            preparedSplinePoints.append(distance)
        }
        
        return preparedSplinePoints
    }
    
    func sRGB_to_lightLiner(_ colorsRGB: Float) -> Float {
        var colorLLiner: Float = 0.0
        if colorsRGB <= 0.04045 {
            colorLLiner = colorsRGB * 0.0774
        }
        else {
            colorLLiner = pow(colorsRGB*0.9479 + 0.05213, 2.4)
        }
        return colorLLiner
    }
    
    func createColorCubeData() -> NSData {
        
        let redCurve = self.getPreparedSplineCurve(point: redCurvePoints)
        let greenCurve = self.getPreparedSplineCurve(point: greenCurvePoints)
        let blueCurve = self.getPreparedSplineCurve(point: blueCurvePoints)
        
        let indexs: [Int] = [  0,   8,  16,  25,  33,  41,  49,  58,
                               66,  74,  82,  90,  99, 107, 115, 123,
                               132, 140, 148, 156, 165, 173, 181, 189,
                               197, 206, 214, 222, 230, 239, 247, 255]
        
        let size = 32
        var colorCubeData:[Float] = []//[Float](repeatElement(0, count: size*size*size*4))
        
        
        
        for b in 0..<32 {
            for g in 0..<32 {
                for r in 0..<32 {
                    
                    // bgra for upload to texture
                    var currentCurveIndex = indexs[b]
                    let bb = fmin(fmax(Float(currentCurveIndex) + blueCurve![currentCurveIndex], 0), 255)
                    
                    currentCurveIndex = indexs[g]
                    let gg = fmin(fmax(Float(currentCurveIndex) + greenCurve![currentCurveIndex], 0), 255)
                    
                    currentCurveIndex = indexs[r]
                    let rr = fmin(fmax(Float(currentCurveIndex) + redCurve![currentCurveIndex], 0), 255)
                    
                    let div: Float = 1.0 / 255.0
                    colorCubeData.append(sRGB_to_lightLiner(rr*div))
                    colorCubeData.append(sRGB_to_lightLiner(gg*div))
                    colorCubeData.append(sRGB_to_lightLiner(bb*div))
                    colorCubeData.append(1)
                    
                }
            }
        }
        return NSData(bytes: colorCubeData, length: size*size*size*4*MemoryLayout<Float>.size)
    }
}
