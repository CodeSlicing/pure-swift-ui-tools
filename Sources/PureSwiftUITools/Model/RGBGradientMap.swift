//
//  GradientMap.swift
//
//  Created by Adam Fordyce on 22/10/2019.
//  Copyright © 2019 Adam Fordyce. All rights reserved.
//

public struct RGBGradientMap {
    
    private var internalGradientMap: [RGBColor]
    
    public var count: Int {
        self.internalGradientMap.count
    }
    
    public init(_ colors: [RGBColor], withResolution resolution: Int) {
        self.internalGradientMap = RGBGradientMap.calculateGradientMap(colors: colors, resolution: resolution)
    }
    
    public subscript(index: Int) -> RGBColor? {
        get {
            if index > internalGradientMap.count - 1 {
                return nil
            } else {
                return internalGradientMap[index]
            }
        }
    }
    
    public subscript(index: Int, default defaultColor: RGBColor) -> RGBColor {
        get {
            self[index] ?? defaultColor
        }
    }
    
    public func colorAt(_ fraction: Double, default defaultColor: Color = .clear) -> Color {
        self[(fraction * (count - 1)).asInt]?.asColor ?? defaultColor
    }

    public func colorAt(_ index: Int, default defaultColor: Color = .clear) -> Color {
        self[index]?.asColor ?? defaultColor
    }

    public static func calculateGradientMap(colors: [RGBColor], resolution: Int) -> [RGBColor] {
        
        var toReturn = [RGBColor]()
        
        let stops = RGBGradientMap.calculateStops(colors: colors)
        
        toReturn.append(colors.first!)
        
        let deltaPerPoint = 1 / resolution.asDouble
        
        for point in 1..<(resolution - 1) {
            
            let fraction = deltaPerPoint * point.asDouble
            let colorToInterpolate: (from: RGBColor, to: RGBColor, fraction: Double) = calculateInterpolationColors(colors: colors, stops: stops, fraction: fraction)
            
            let color = colorToInterpolate.from.interpolate(to: colorToInterpolate.to, fraction: colorToInterpolate.fraction)
            
            toReturn.append(color)
        }
        toReturn.append(colors.last!)
        
        return toReturn
    }
    
    public static func calculateStops(colors: [RGBColor]) -> [Double] {
            
        let fractionPerStop = 1 / (colors.count.asDouble - 1)
        
        var stops = [Double]()
        
        stops.append(0)
        for i in 1..<(colors.count - 1) {
            stops.append(fractionPerStop * i.asDouble)
        }
        stops.append(1)
        
        return stops
    }
    
    public static func calculateInterpolationColors(colors: [RGBColor], stops: [Double], fraction: Double) -> (RGBColor, RGBColor, Double) {
        
        var startIndex = 0
        var endIndex = stops.count - 1
        
        for i in 1..<stops.count {
            
            if stops[i] < fraction {
                startIndex = i
            } else {
                endIndex = i
                break
            }
        }
        let startFraction = stops[startIndex]
        let endFraction = stops[endIndex]
        let relativeFraction = (fraction - startFraction) / (endFraction - startFraction)
        
        return (colors[startIndex], colors[endIndex], relativeFraction)
    }
}
