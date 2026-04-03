//
//  HypotrochoidLoopShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct HypotrochoidLoopShape: ParametricShape {
    public static let sampleCount: Int = 760
    public static let range: ClosedRange<Double> = 0 ... (2 * .pi)

    public struct Context {
        let innerAngle: Double
    }

    public let outerRadius: Double
    public let innerRadius: Double
    public let distance: Double

    public var radiusDelta: Double { outerRadius - innerRadius }

    public init(
        outerRadius: Double = 8.2,
        innerRadius: Double = 2.75,
        distance: Double = 4.8
    ) {
        self.outerRadius = outerRadius
        self.innerRadius = innerRadius
        self.distance = distance
    }

    public func makeContext(_ angle: Double) -> Context {
        Context(
            innerAngle: radiusDelta / innerRadius * angle
        )
    }

    public func x(_ angle: Double, context: Context) -> Double {
        radiusDelta * cos(angle) + distance * cos(context.innerAngle)
    }

    public func y(_ angle: Double, context: Context) -> Double {
        radiusDelta * sin(angle) - distance * sin(context.innerAngle)
    }
}

public extension SwiftUI.Shape where Self == HypotrochoidLoopShape {
    static var hypotrochoidLoop: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .hypotrochoidLoop)
}
