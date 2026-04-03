//
//  HeartWaveShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct HeartWaveShape: ParametricShape {
    public static let sampleCount: Int = 10000
    public static let range: ClosedRange<Double> = 0 ... 1

    public struct Context {
        let x: Double
        let rootFactor: Double
    }

    public let waveFrequency: Double
    public let rootSpan: Double
    public let waveAmplitude: Double

    public init(
        waveFrequency: Double = 6.4,
        rootSpan: Double = 3.3,
        waveAmplitude: Double = 0.9
    ) {
        self.waveFrequency = waveFrequency
        self.rootSpan = rootSpan
        self.waveAmplitude = waveAmplitude
    }

    public func makeContext(_ progress: Double) -> Context {
        let xLimit = sqrt(rootSpan)
        let xValue = -xLimit + progress * xLimit * 2
        let safeRoot = max(0, rootSpan - xValue * xValue)

        return Context(
            x: xValue,
            rootFactor: sqrt(safeRoot)
        )
    }

    public func x(_ progress: Double, context: Context) -> Double {
        context.x
    }

    public func y(_ progress: Double, context: Context) -> Double {
        let wave = waveAmplitude * context.rootFactor * sin(waveFrequency * Double.pi * context.x)
        let curve = pow(abs(context.x), 2.0 / 3.0)
        return -(curve + wave)
    }
}

public extension SwiftUI.Shape where Self == HeartWaveShape {
    static var heartWave: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .heartWave)
}
