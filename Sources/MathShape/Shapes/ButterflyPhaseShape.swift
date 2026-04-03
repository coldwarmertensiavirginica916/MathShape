//
//  ButterflyPhaseShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct ButterflyPhaseShape: ParametricShape {
    public static let sampleCount: Int = 1400
    public static let range: ClosedRange<Double> = 0 ... 1

    public struct Context {
        let angle: Double
        let butterflyEnvelope: Double
    }

    public let turnCount: Double
    public let cosineWeight: Double
    public let power: Int

    public init(
        turnCount: Double = 12,
        cosineWeight: Double = 2,
        power: Int = 5
    ) {
        self.turnCount = turnCount
        self.cosineWeight = cosineWeight
        self.power = power
    }

    public func makeContext(_ progress: Double) -> Context {
        let angle = progress * Double.pi * turnCount
        let butterflyEnvelope = exp(cos(angle)) - cosineWeight * cos(4 * angle) - pow(sin(angle / 12), Double(power))
        return Context(
            angle: angle,
            butterflyEnvelope: butterflyEnvelope
        )
    }

    public func x(_ progress: Double, context: Context) -> Double {
        sin(context.angle) * context.butterflyEnvelope
    }

    public func y(_ progress: Double, context: Context) -> Double {
        cos(context.angle) * context.butterflyEnvelope
    }
}

public extension SwiftUI.Shape where Self == ButterflyPhaseShape {
    static var butterflyPhase: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .butterflyPhase)
}
