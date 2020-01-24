//
//  RGBColor.swift
//
//  Created by Adam Fordyce on 22/10/2019.
//  Copyright © 2019 Adam Fordyce. All rights reserved.
//

import PureSwiftUI

import SwiftUI

public struct RGBColor: Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    public init(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1) {
        self.red = r
        self.green = g
        self.blue = b
        self.alpha = a
    }
    
    private static let equalsTolerance = 0.0001
    
    public static func == (lhs: RGBColor, rhs: RGBColor) -> Bool {
        return abs(lhs.red - rhs.red) <= equalsTolerance &&
            abs(lhs.green - rhs.green) <= equalsTolerance &&
            abs(lhs.blue - rhs.blue) <= equalsTolerance
    }
}

// MARK: ----- INTERPOLATION

public extension RGBColor {

    func interpolate(to targetColor: RGBColor, fraction: Double) -> RGBColor {
        Self.interpolateColor(from: self, to: targetColor, fraction: fraction)
    }

    static func interpolateColor(from: RGBColor, to: RGBColor, fraction: Double) -> RGBColor {

        return RGBColor(
            interpolateValue(from: from.red, to: to.red, fraction: fraction),
            interpolateValue(from: from.green, to: to.green, fraction: fraction),
            interpolateValue(from: from.blue, to: to.blue, fraction: fraction),
            interpolateValue(from: from.alpha, to: to.alpha, fraction: fraction)
        )
    }

    static func interpolateValue(from: Double, to: Double, fraction: Double) -> Double {

        let range = to - from
        let fractionalRange = range * fraction
        return from + fractionalRange
    }
}

// MARK: ----- SYSTEM COLORS

public extension RGBColor {

    // SwiftUI colors
    static let white = RGBColor(1, 1, 1)
    static let black = RGBColor(0, 0, 0)
    static let gray = RGBColor(142 / 255, 142 / 255, 142 / 255)
    static let red = RGBColor(1,58 / 255, 48 / 255)
    static let green = RGBColor(52.0 / 255 , 199.0 / 255, 89.0 / 255)
    static let blue = RGBColor(0, 122 / 255, 1)
    static let orange = RGBColor(1, 149 / 255, 0)
    static let yellow = RGBColor(1, 204 / 255, 1.0 / 255)
    static let pink = RGBColor(1, 44 / 255, 85 / 255)
    static let purple = RGBColor(175 / 255, 82 / 255, 222 / 255)
    static let clear = RGBColor(0, 0, 0, 0)
    
    // pure colors
    static let pureRed = RGBColor(1, 0, 0)
    static let pureGreen = RGBColor(0, 1, 0)
    static let pureBlue = RGBColor(0, 0, 1)
    static let pureYellow = RGBColor(1, 1, 0)
    static let pureMagenta = RGBColor(1, 0, 1)
    static let pureOrange = RGBColor(1, 0.5, 0)
    static let purePurple = RGBColor(0.5, 0, 0.5)
}

// MARK: ----- OPACITY

public extension RGBColor {

    func withRed(_ value: Double) -> RGBColor {
        var newRGB = self
        newRGB.red = value
        return newRGB
    }
    
    func withGreen(_ value: Double) -> RGBColor {
        var newRGB = self
        newRGB.green = value
        return newRGB
    }
    
    func withBlue(_ value: Double) -> RGBColor {
        var newRGB = self
        newRGB.blue = value
        return newRGB
    }

    func withOpacity(_ value: Double) -> RGBColor {
        var newRGB = self
        newRGB.alpha = value
        return newRGB
    }
}

// MARK: ----- TYPE COERCION

public extension RGBColor {
    
    var asColor: Color {
        Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    
    var asCGColor: CGColor {
        CGColor(srgbRed: red.asCGFloat, green: green.asCGFloat, blue: blue.asCGFloat, alpha: alpha.asCGFloat)
    }

    var asUIColor: UIColor {
        UIColor(ciColor: asCIColor)
    }

    var asCIColor: CIColor {
        CIColor(red: red.asCGFloat, green: green.asCGFloat, blue: blue.asCGFloat, alpha: alpha.asCGFloat)
    }
}

// MARK: ----- FOUNDATION EXTENSIONS

public extension CIColor {
    
    var asRGBColor: RGBColor {
        return RGBColor(self.red.asDouble, self.green.asDouble, self.blue.asDouble, self.alpha.asDouble)
    }
}

public extension UIColor {
    
    var asRGBColor: RGBColor {
        CIColor(color: self).asRGBColor
    }
}

public extension CGColor {
    
    var asRGBColor: RGBColor {
        CIColor(cgColor: self).asRGBColor
    }
}
