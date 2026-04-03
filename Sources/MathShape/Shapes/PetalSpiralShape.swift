//
//  PetalSpiralShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct PetalSpiralShape: ParametricShape {
    public let outerRadius: Double
    public let innerRadius: Double
    public let distance: Double

    private var radiusDelta: Double {
        outerRadius - innerRadius
    }

    public init(
        outerRadius: Double,
        innerRadius: Double = 1,
        distance: Double = 3
    ) {
        self.outerRadius = outerRadius
        self.innerRadius = innerRadius
        self.distance = distance
    }
    
    static public var sampleCount: Int { 640 }
    static public var range: ClosedRange<Double> { 0 ... (2 * .pi) }

    public struct Context {
        let innerAngle: Double
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

extension SwiftUI.Shape where Self == PetalSpiralShape {
    static public func petalSpiral(_ outerRadius: Double) -> Self { .init(outerRadius: outerRadius) }
}

#Preview {
    ParametricShapePreview(shape: .petalSpiral(4))
}
