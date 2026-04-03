//
//  LissajousDriftShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/2.
//

import SwiftUI

public struct LissajousDriftShape: ParametricShape {
    static public let sampleCount: Int = 300
    static public let range: ClosedRange<Double> = 0 ... (2 * .pi)
    
    public init() {
        
    }
    
    public func x(_ t: Double, context: Context) -> Double {
        sin(3 * t + .pi / 2)
    }

    public func y(_ t: Double, context: Context) -> Double {
        sin(4 * t)
    }
}

public extension SwiftUI.Shape where Self == LissajousDriftShape {
    static var lissajousDrift: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .lissajousDrift)
}
