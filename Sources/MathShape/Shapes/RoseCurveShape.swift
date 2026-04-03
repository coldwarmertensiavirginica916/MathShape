//
//  RoseCurveShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct RoseCurveShape: ParametricShape {
    public let k: Int

    public init(k: Int) {
        self.k = k
    }
    
    static public var sampleCount: Int { 520 }
    static public var range: ClosedRange<Double> { 0 ... (2 * .pi) }

    public func x(_ angle: Double, context: Context) -> Double {
        cos(angle) * cos(Double(k) * angle)
    }

    public func y(_ angle: Double, context: Context) -> Double {
        sin(angle) * cos(Double(k) * angle)
    }
}

public extension SwiftUI.Shape where Self == RoseCurveShape {
    static func roseCurve(_ k: Int) -> Self { .init(k: k) }
}

#Preview {
    ParametricShapePreview(shape: .roseCurve(5))
}
