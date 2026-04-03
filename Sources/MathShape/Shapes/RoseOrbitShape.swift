//
//  RoseOrbitShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct RoseOrbitShape: ParametricShape {
    public let k: Int
    public let orbitRadius: Double
    public let detailAmplitude: Double

    public init(
        k: Int = 7,
        orbitRadius: Double = 7,
        detailAmplitude: Double = 2.7
    ) {
        self.k = k
        self.orbitRadius = orbitRadius
        self.detailAmplitude = detailAmplitude
    }
    
    static public var sampleCount: Int { 1000 }
    static public var range: ClosedRange<Double> { 0 ... (2 * .pi) }
    
    public struct Context {
        var radius: Double
    }
    
    public func makeContext(_ angle: Double) -> Context {
        Context(
            radius: orbitRadius - detailAmplitude * cos(Double(k) * angle)
        )
    }
    
    public func x(_ angle: Double, context: Context) -> Double {
        cos(angle) * context.radius
    }

    public func y(_ angle: Double, context: Context) -> Double {
        sin(angle) * context.radius
    }
}

public extension SwiftUI.Shape where Self == RoseOrbitShape {
    static var roseOrbit: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .roseOrbit)
}
