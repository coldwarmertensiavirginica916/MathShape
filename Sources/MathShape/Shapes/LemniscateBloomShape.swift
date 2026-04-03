//
//  LemniscateBloomShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct LemniscateBloomShape: ParametricShape {
    public static let sampleCount: Int = 520
    public static let range: ClosedRange<Double> = 0 ... (2 * .pi)

    public struct Context {
        let sin: Double
        let cos: Double
        let inverseDenominator: Double
    }

    public init() {
        
    }

    public func makeContext(_ angle: Double) -> Context {
        let sin = sin(angle)
        let cos = cos(angle)
        let denominator = 1 + sin * sin

        return Context(
            sin: sin,
            cos: cos,
            inverseDenominator: 1 / denominator
        )
    }

    public func x(_ angle: Double, context: Context) -> Double {
        context.cos * context.inverseDenominator
    }

    public func y(_ angle: Double, context: Context) -> Double {
        context.sin * context.cos * context.inverseDenominator
    }
}

public extension SwiftUI.Shape where Self == LemniscateBloomShape {
    static var lemniscateBloom: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .lemniscateBloom)
}
