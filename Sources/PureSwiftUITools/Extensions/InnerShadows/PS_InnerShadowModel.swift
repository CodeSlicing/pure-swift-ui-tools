//
//  PS_InnerShadowModel.swift
//  
//
//  Created by Adam Fordyce on 06/03/2020.
//

import PureSwiftUI

public let ps_defaultInnerShadowColor = Color(white: 0.56)

private func convertIntensityToColor<T: UINumericType>(_ intensity: T) -> Color {
    return Color(white: 1 - intensity.asDouble.clamped(to: 1, spanZero: false))
}

public struct PS_InnerShadowConfig {
    
    let radius: CGFloat
    let offsetLength: CGFloat!
    let offset: CGPoint!
    let angle: Angle!
    let color: Color!
    
    private init<TR: UINumericType>(radiusInternal: TR, offsetLength: CGFloat? = nil, offset: CGPoint? = nil, angle: Angle? = nil, color: Color = ps_defaultInnerShadowColor) {
        self.radius = radiusInternal.asCGFloat
        self.offsetLength = offsetLength
        self.offset = offset
        self.angle = angle
        self.color = color
    }
    
    public init<TR: UINumericType, TO: UINumericType>(radius: TR, offsetLength: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) {
        self.init(radiusInternal: radius, offsetLength: offsetLength.asCGFloat, angle: angle, color: color)
    }
    
    public init<TR: UINumericType, TO: UINumericType, TI: UINumericType>(radius: TR, offsetLength: TO, angle: Angle, intensity: TI) {
        self.init(radius: radius, offsetLength: offsetLength, angle: angle, color: convertIntensityToColor(intensity))
    }

    public init<TR: UINumericType>(radius: TR, offset: CGPoint, color: Color = ps_defaultInnerShadowColor) {
        self.init(radiusInternal: radius, offset: offset, color: color)
    }
    
    public init<TR: UINumericType, TI: UINumericType>(radius: TR, offset: CGPoint, intensity: TI) {
        self.init(radius: radius, offset: offset, color: convertIntensityToColor(intensity))
    }
    
    public init<TR: UINumericType>(radius: TR, color: Color = ps_defaultInnerShadowColor) {
        self.init(radiusInternal: radius, offset: .zero, color: color)
    }
    
    public init<TR: UINumericType, TI: UINumericType>(radius: TR, intensity: TI) {
        self.init(radius: radius, offset: .zero, intensity: intensity)
    }
    
    var hasAngle: Bool {
        angle != nil
    }
}

public extension PS_InnerShadowConfig {
    
    static func config<TR: UINumericType, TI: UINumericType>(radius: TR, intensity: TI) -> PS_InnerShadowConfig {
        config(radius: radius, offset: .zero, intensity: intensity)
    }
    
    static func config<TR: UINumericType>(radius: TR, color: Color = ps_defaultInnerShadowColor) -> PS_InnerShadowConfig {
        config(radius: radius, offset: .zero, color: color)
    }
    
    static func config<TR: UINumericType, TO: UINumericType, TI: UINumericType>(radius: TR, offset: TO, angle: Angle, intensity: TI) -> PS_InnerShadowConfig {
        config(radius: radius, offset: offset, angle: angle, color: convertIntensityToColor(intensity))
    }
    
    static func config<TR: UINumericType, TO: UINumericType>(radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> PS_InnerShadowConfig {
        PS_InnerShadowConfig(radius: radius, offsetLength: offset, angle: angle, color: color)
    }

    static func config<TR: UINumericType, TI: UINumericType>(radius: TR, offset: CGPoint, intensity: TI) -> PS_InnerShadowConfig {
        config(radius: radius, offset: offset, color: convertIntensityToColor(intensity))
    }
    
    static func config<TR: UINumericType>(radius: TR, offset: CGPoint, color: Color = ps_defaultInnerShadowColor) -> PS_InnerShadowConfig {
        PS_InnerShadowConfig(radius: radius, offset: offset, color: color)
    }
}

public struct FillAndContent<V: View> {
    let fillStyle: FillStyle
    let content: V?
}

public extension FillAndContent {
    
    static var fill: FillAndContent<Color> {
        fill(Color.clear)
    }
    
    static func fill(eoFill: Bool = false, antialiased: Bool = true) -> FillAndContent<Color> {
        fill(Color.clear, eoFill: eoFill, antialiased: antialiased)
    }
    
    static func fill<V: View>(_ content: V, eoFill: Bool = false, antialiased: Bool = true) -> FillAndContent<V> {
        FillAndContent<V>(fillStyle: FillStyle(eoFill: eoFill, antialiased: antialiased), content: content)
    }
}

public struct StrokeAndContent<V: View> {
    let style: StrokeStyle
    let fillAndContent: FillAndContent<V>
}

public extension StrokeAndContent {
    static func stroke<T: UINumericType>(lineWidth: T) -> StrokeAndContent<Color> {
        stroke(Color.clear, lineWidth: lineWidth)
    }
    
    static func stroke<V: View, T: UINumericType>(_ content: V, lineWidth: T) -> StrokeAndContent<V> {
        StrokeAndContent<V>(style: StrokeStyle(lineWidth: lineWidth.asCGFloat), fillAndContent: .fill(content))
    }
    
    static func stroke(style: StrokeStyle) -> StrokeAndContent<Color> {
        stroke(Color.clear, style: style)
    }
    
    static func stroke<V: View>(_ content: V, style: StrokeStyle) -> StrokeAndContent<V> {
        StrokeAndContent<V>(style: style, fillAndContent: .fill(content))
    }
}

public struct ShapeAndContent<S: Shape, V: View> {
    let shape: S
    let content: V?
    
    init(_ shape: S, _ content: V? = nil) {
        self.shape = shape
        self.content = content
    }
}

public extension ShapeAndContent {
    
    static var circle: ShapeAndContent<Circle, Color> {
        circle(Color.clear)
    }
    
    static func circle<V: View>(_ content: V? = nil) -> ShapeAndContent<Circle, V> {
        ShapeAndContent<Circle, V>(Circle(), content)
    }
    
    static var ellipse: ShapeAndContent<Ellipse, Color> {
        ellipse(Color.clear)
    }
    
    static func ellipse<V: View>(_ content: V? = nil) -> ShapeAndContent<Ellipse, V> {
        ShapeAndContent<Ellipse, V>(Ellipse(), content)
    }
    
    static var capsule: ShapeAndContent<Capsule, Color> {
        capsule(Color.clear)
    }
    
    static func capsule<V: View>(_ content: V? = nil) -> ShapeAndContent<Capsule, V> {
        ShapeAndContent<Capsule, V>(Capsule(), content)
    }

    static var rectangle: ShapeAndContent<Rectangle, Color> {
        rectangle(Color.clear)
    }
    
    static func rectangle<V: View>(_ content: V? = nil) -> ShapeAndContent<Rectangle, V> {
        ShapeAndContent<Rectangle, V>(Rectangle(), content)
    }
    
    static func roundedRectangle<T: UINumericType>(_ cornerRadius: T) -> ShapeAndContent<RoundedRectangle, Color> {
        roundedRectangle(cornerRadius, Color.clear)
    }
    
    static func roundedRectangle<T: UINumericType, V: View>(_ cornerRadius: T, _ content: V? = nil) -> ShapeAndContent<RoundedRectangle, V> {
        ShapeAndContent<RoundedRectangle, V>(RoundedRectangle(cornerRadius), content)
    }
}
