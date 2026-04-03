//
//  CardioidGlowShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct CardioidGlowShape: ParametricShape {
    public static let sampleCount: Int = 520
    public static let range: ClosedRange<Double> = 0 ... (2 * .pi)

    public init() {
        
    }

    public func x(_ angle: Double, context: Context) -> Double {
        cos(angle) * (1 - cos(angle))
    }

    public func y(_ angle: Double, context: Context) -> Double {
        sin(angle) * (1 - cos(angle))
    }
}

public extension SwiftUI.Shape where Self == CardioidGlowShape {
    static var cardioidGlow: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .cardioidGlow)
}
