//
//  PS_InnerShadowExtensions.swift
//  
//
//  Created by Adam Fordyce on 06/03/2020.
//

import PureSwiftUI

public extension View {
    
    func ps_innerShadow<T: UINumericType>(_ config: PS_InnerShadowConfig) -> some View {
        ps_innerShadow(ShapeAndContent(Rectangle(), Color.clear), config)
    }
    
    func ps_innerShadow<T: UINumericType>(radius: T, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(ShapeAndContent(Rectangle(), Color.clear), radius: radius, offset: offset, color: color)
    }
    
    func ps_innerShadow<T: UINumericType, TD: UINumericType>(radius: T, offset: CGPoint = .zero, intensity: TD) -> some View {
        ps_innerShadow(ShapeAndContent(Rectangle(), Color.clear), .config(radius: radius, offset: offset, intensity: intensity))
    }

    func ps_innerShadow<S: Shape, V: View>(_ shapeContent: ShapeAndContent<S, V>, _ config: PS_InnerShadowConfig) -> some View {
        let decoration = Color.clear.background(shapeContent.shape.ps_innerShadow(.fill(shapeContent.content), config))
            .clipShape(shapeContent.shape)
        let color = shapeContent.content as? Color
        return RenderIf(color != nil && color == .clear) {
            self.overlay(decoration)
        }.elseRender {
            self.background(decoration)
        }
    }
    
    func ps_innerShadow<S: Shape, V: View, TR: UINumericType>(_ shapeContent: ShapeAndContent<S, V>, radius: TR, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(shapeContent, .config(radius: radius, offset: offset, color: color))
    }
    
    func ps_innerShadow<S: Shape, V: View, TR: UINumericType, TD: UINumericType>(_ shapeContent: ShapeAndContent<S, V>, radius: TR, offset: CGPoint = .zero, intensity: TD) -> some View {
        ps_innerShadow(shapeContent, .config(radius: radius, offset: offset, intensity: intensity))
    }

}
// MARK: ----- INNER SHADOW OFFSET AND ANGLE

public extension View {
    
    func ps_innerShadow(_ config: PS_InnerShadowConfig) -> some View {
        ps_innerShadow(Color.clear, config)
    }
    
    func ps_innerShadow<TR: UINumericType, TO: UINumericType, TI: UINumericType>(radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(Color.clear, radius: radius, offset: offset, angle: angle, intensity: intensity)
    }
    
    func ps_innerShadow<TR: UINumericType, TO: UINumericType>(radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(Color.clear, radius: radius, offset: offset, angle: angle, color: color)
    }
    
    func ps_innerShadow<V: View>(_ content: V, _ config: PS_InnerShadowConfig) -> some View {
        ps_innerShadow(.rectangle(content), config)
    }
    
    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType, TI: UINumericType>(_ content: V, radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(.rectangle(content), radius: radius, offset: offset, angle: angle, intensity: intensity)
    }
    
    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType>(_ content: V, radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(.rectangle(content), radius: radius, offset: offset, angle: angle, color: color)
    }

    func ps_innerShadow<S: Shape, V: View, TR: UINumericType, TO: UINumericType, TI: UINumericType>(_ shapeContent: ShapeAndContent<S, V>, radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(shapeContent, .config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }

    func ps_innerShadow<S: Shape, V: View, TR: UINumericType, TO: UINumericType>(_ shapeContent: ShapeAndContent<S, V>, radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(shapeContent, .config(radius: radius, offset: offset, angle: angle, color: color))
    }
}

public extension Image {
    
    
    func ps_innerShadow<V: View>(_ content: V, _ config: PS_InnerShadowConfig) -> some View {
        RenderIf(config.hasAngle) {
            self.modifier(PSInnerShadowImageOffsetWithAngleViewModifier(image: self, content: content, radius: config.radius, offset: config.offsetLength, angle: config.angle, color: config.color))
        }.elseRender {
            self.modifier(PSInnerShadowImageOffsetViewModifier(image: self, content: content, radius: config.radius, offset: config.offset, color: config.color))
        }
    }
    
    func ps_innerShadow<V: View, T: UINumericType, TI: UINumericType>(_ content: V, radius: T, offset: CGPoint = .zero, intensity: TI) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, intensity: intensity))
    }
    
    func ps_innerShadow<V: View, T: UINumericType>(_ content: V, radius: T, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, color: color))
    }

    func ps_innerShadow(_ config: PS_InnerShadowConfig) -> some View {
        ps_innerShadow(Color.clear, config)
    }

    func ps_innerShadow<T: UINumericType, TI: UINumericType>(radius: T, offset: CGPoint = .zero, intensity: TI) -> some View {
        ps_innerShadow(Color.clear, .config(radius: radius, offset: offset, intensity: intensity))
    }

    func ps_innerShadow<T: UINumericType>(radius: T, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(Color.clear, .config(radius: radius, offset: offset, color: color))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType, TI: UINumericType>(_ content: V, radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType>(_ content: V, radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, angle: angle, color: color))
    }

    func ps_innerShadow<TR: UINumericType, TO: UINumericType, TI: UINumericType>(radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(.config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }

    func ps_innerShadow<TR: UINumericType, TO: UINumericType>(radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(.config(radius: radius, offset: offset, angle: angle, color: color))
    }
}

// MARK: ----- GENERIC ON SHAPE

public extension Shape {
    
    internal func addPSInnerShadow<S: Shape, V: View>(_ shape: S, _ fillAndContent: FillAndContent<V>, _ config: PS_InnerShadowConfig) -> some View {
        RenderIf(config.hasAngle) {
            fillAndContent.content.clipShape(shape, style: fillAndContent.fillStyle)
                .modifier(PSInnerShadowShapeOffsetWithAngleViewModifier(shape: shape, fillStyle: fillAndContent.fillStyle, radius: config.radius, offset: config.offsetLength, angle: config.angle, color: config.color))
        }.elseRender {
            fillAndContent.content.clipShape(shape, style: fillAndContent.fillStyle)
                .modifier(PSInnerShadowShapeOffsetViewModifier(shape: shape, fillStyle: fillAndContent.fillStyle, radius: config.radius, offset: config.offset, color: config.color))
        }
    }
}

// MARK: ----- GENERIC ON SHAPE STROKE

public extension Shape {
    
    func ps_innerShadow<V: View, TR: UINumericType, TI: UINumericType>(_ strokeAndContent: StrokeAndContent<V>, radius: TR, offset: CGPoint = .zero, intensity: TI) -> some View {
        ps_innerShadow(strokeAndContent, .config(radius: radius, offset: offset, intensity: intensity))
    }
    
    func ps_innerShadow<V: View, TR: UINumericType>(_ strokeAndContent: StrokeAndContent<V>, radius: TR, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(strokeAndContent, .config(radius: radius, offset: offset, color: color))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType, TI: UINumericType>(_ strokeAndContent: StrokeAndContent<V>, radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(strokeAndContent, .config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType>(_ strokeAndContent: StrokeAndContent<V>, radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(strokeAndContent, .config(radius: radius, offset: offset, angle: angle, color: color))
    }

    func ps_innerShadow<V: View>(_ strokeAndContent: StrokeAndContent<V>, _ config: PS_InnerShadowConfig) -> some View {
        let strokedShape = stroke(style: strokeAndContent.style)
        return strokedShape
            .addPSInnerShadow(strokedShape, strokeAndContent.fillAndContent, config)
    }
}

public extension Shape {
    
    
    func ps_innerShadow<V: View, TR: UINumericType, TI: UINumericType>(_ fillAndContent: FillAndContent<V>, radius: TR, offset: CGPoint = .zero, intensity: TI) -> some View {
        ps_innerShadow(fillAndContent, .config(radius: radius, offset: offset, intensity: intensity))
    }
    
    func ps_innerShadow<V: View, TR: UINumericType>(_ fillAndContent: FillAndContent<V>, radius: TR, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(fillAndContent, .config(radius: radius, offset: offset, color: color))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType, TI: UINumericType>(_ fillAndContent: FillAndContent<V>, radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(fillAndContent, .config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType>(_ fillAndContent: FillAndContent<V>, radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(fillAndContent, .config(radius: radius, offset: offset, angle: angle, color: color))
    }

    func ps_innerShadow<V: View>(_ fillAndContent: FillAndContent<V>, _ config: PS_InnerShadowConfig) -> some View {
        self.addPSInnerShadow(self, fillAndContent, config)
    }
}

// MARK: ----- TEXT INNER SHADOW WITH OFFSET

public extension Text {
    
    internal func addPSInnerShadow<V: View>(_ content: V, _ config: PS_InnerShadowConfig) -> some View {
        RenderIf(config.hasAngle) {
            self.modifier(PSInnerShadowTextOffsetWithAngleViewModifier(text: self, content: content, radius: config.radius, offset: config.offsetLength, angle: config.angle, color: config.color))
        }.elseRender {
            self.modifier(PSInnerShadowTextOffsetViewModifier(text: self, content: content, radius: config.radius, offset: config.offset, color: config.color))
        }
    }
    
    func ps_innerShadow<T: UINumericType, TI: UINumericType>(radius: T, offset: CGPoint = .zero, intensity: TI) -> some View {
        ps_innerShadow(Color.clear, .config(radius: radius, offset: offset, intensity: intensity))
    }
    
    func ps_innerShadow<V: View, T: UINumericType, TI: UINumericType>(_ content: V, radius: T, offset: CGPoint = .zero, intensity: TI) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, intensity: intensity))
    }

    func ps_innerShadow<T: UINumericType>(radius: T, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(Color.clear, .config(radius: radius, offset: offset, color: color))
    }

    func ps_innerShadow<V: View, T: UINumericType>(_ content: V, radius: T, offset: CGPoint = .zero, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, color: color))
    }

    func ps_innerShadow(_ config: PS_InnerShadowConfig) -> some View {
        ps_innerShadow(Color.clear, config)
    }

    func ps_innerShadow<V: View>(_ content: V, _ config: PS_InnerShadowConfig) -> some View {
        addPSInnerShadow(content, config)
    }
}

// MARK: ----- TEXT INNER SHADOW WITH OFFSET AND ANGLE

public extension Text {
    
    func ps_innerShadow<TR: UINumericType, TO: UINumericType, TI: UINumericType>(radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(Color.clear, .config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }
    
    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType, TI: UINumericType>(_ content: V, radius: TR, offset: TO, angle: Angle, intensity: TI) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, angle: angle, intensity: intensity))
    }

    func ps_innerShadow<TR: UINumericType, TO: UINumericType>(radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(Color.clear, .config(radius: radius, offset: offset, angle: angle, color: color))
    }

    func ps_innerShadow<V: View, TR: UINumericType, TO: UINumericType>(_ content: V, radius: TR, offset: TO, angle: Angle, color: Color = ps_defaultInnerShadowColor) -> some View {
        ps_innerShadow(content, .config(radius: radius, offset: offset, angle: angle, color: color))
    }

}
