//
//  ThinkingShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct ThinkingShape: ParametricShape {
    public let baseRadius: Double
    public let detailAmplitude: Double
    public let k: Int
    
    static public var sampleCount: Int { 480 }
    static public var range: ClosedRange<Double> { 0 ... (2 * .pi) }

    public init(
        k: Int,
        baseRadius: Double = 7,
        detailAmplitude: Double = 3,
    ) {
        self.k = k
        self.baseRadius = baseRadius
        self.detailAmplitude = detailAmplitude
    }
    
    public struct Context {
        let detailAngle: Double
    }
    
    public func makeContext(_ angle: Double) -> Context {
        Context(
            detailAngle: Double(k) * angle
        )
    }

    public func x(_ angle: Double, context: Context) -> Double {
        baseRadius * cos(angle) - detailAmplitude * cos(context.detailAngle)
    }

    public func y(_ angle: Double, context: Context) -> Double {
        baseRadius * sin(angle) - detailAmplitude * sin(context.detailAngle)
    }
}

extension SwiftUI.Shape where Self == ThinkingShape {
    static public func thinking(_ k: Int) -> Self { .init(k: k) }
}

#Preview {
    ParametricShapePreview(shape: .thinking(3))
}
