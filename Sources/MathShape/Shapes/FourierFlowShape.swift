//
//  FourierFlowShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public struct FourierFlowShape: ParametricShape {
    public static let sampleCount: Int = 760
    public static let range: ClosedRange<Double> = 0 ... (2 * .pi)

    public let firstXCosine: Double
    public let thirdXCosine: Double
    public let fifthXSine: Double
    public let firstYSine: Double
    public let secondYSine: Double
    public let fourthYCosine: Double
    public let mixBase: Double

    public init(
        firstXCosine: Double = 17,
        thirdXCosine: Double = 7.5,
        fifthXSine: Double = 3.2,
        firstYSine: Double = 15,
        secondYSine: Double = 8.2,
        fourthYCosine: Double = 4.2,
        mixBase: Double = 1
    ) {
        self.firstXCosine = firstXCosine
        self.thirdXCosine = thirdXCosine
        self.fifthXSine = fifthXSine
        self.firstYSine = firstYSine
        self.secondYSine = secondYSine
        self.fourthYCosine = fourthYCosine
        self.mixBase = mixBase
    }

    public func x(_ angle: Double, context: Void) -> Double {
        firstXCosine * cos(angle) + thirdXCosine * cos(3 * angle + 0.6 * mixBase) + fifthXSine * sin(5 * angle - 0.4)
    }

    public func y(_ angle: Double, context: Void) -> Double {
        firstYSine * sin(angle) + secondYSine * sin(2 * angle + 0.25) - fourthYCosine * cos(4 * angle - 0.5 * mixBase)
    }
}

public extension SwiftUI.Shape where Self == FourierFlowShape {
    static var fourierFlow: Self { .init() }
}

#Preview {
    ParametricShapePreview(shape: .fourierFlow)
}
