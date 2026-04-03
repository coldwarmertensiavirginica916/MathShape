//
//  SpiralSearchShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct SpiralSearchShape: ParametricShape {
    public static let sampleCount: Int = 840
    public static let range: ClosedRange<Double> = 0 ... (2 * .pi)

    public struct Context {
        let spiralCosine: Double
        let spiralSine: Double
        let radius: Double
    }

    public let turnCount: Double
    public let baseRadius: Double
    public let radiusAmplitude: Double

    public init(
        turnCount: Double = 2,
        baseRadius: Double = 8,
        radiusAmplitude: Double = 8.5
    ) {
        self.turnCount = turnCount
        self.baseRadius = baseRadius
        self.radiusAmplitude = radiusAmplitude
    }

    public func makeContext(_ angle: Double) -> Context {
        let spiralAngle = angle * turnCount
        let angularCosine = cos(angle)

        return Context(
            spiralCosine: cos(spiralAngle),
            spiralSine: sin(spiralAngle),
            radius: baseRadius + (1 - angularCosine) * radiusAmplitude
        )
    }

    public func x(_ angle: Double, context: Context) -> Double {
        context.spiralCosine * context.radius
    }

    public func y(_ angle: Double, context: Context) -> Double {
        context.spiralSine * context.radius
    }
}

public extension SwiftUI.Shape where Self == SpiralSearchShape {
    static var spiralSearch: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .spiralSearch)
}
