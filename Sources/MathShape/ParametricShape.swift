//
//  ParametricShape.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

public protocol ParametricShape: SwiftUI.Shape {
    nonisolated static var sampleCount: Int { get }
    nonisolated static var range: ClosedRange<Double> { get }
    
    associatedtype Context = Void
    nonisolated func makeContext(_ t: Double) -> Context
    
    nonisolated func x(_ t: Double, context: Context) -> Double
    nonisolated func y(_ t: Double, context: Context) -> Double
}

extension ParametricShape {
    // FIXME: This should be dynamic. For easy shapes, reduce sample count, and for complex shapes, increase sample count to make the curve look smoother
    nonisolated public static var sampleCount: Int { 10000 }
}

extension ParametricShape where Context == Void {
    nonisolated public func makeContext(_ t: Double) -> Context {
        return ()
    }
}

extension ParametricShape {
    nonisolated public static var role: ShapeRole { .stroke }
    
    nonisolated public func path(in rect: CGRect) -> Path {
        assert(Self.sampleCount > 1, "Sample count must be greater than 1.")

        let range = Self.range
        let sampledPoints: [CGPoint] = (0...Self.sampleCount).map { index in
            let progress = Double(index) / Double(Self.sampleCount)
            let t = range.lowerBound + (range.upperBound - range.lowerBound) * progress

            let context = makeContext(t)
            let sampledX = x(t, context: context)
            let sampledY = y(t, context: context)

            return CGPoint(
                x: sampledX,
                y: sampledY
            )
        }

        let pointBounds = sampledPoints.reduce(into: CGRect.null) { bounds, point in
            bounds = bounds.union(CGRect(origin: point, size: .zero))
        }.standardized

        guard !pointBounds.isNull, !sampledPoints.isEmpty else {
            return Path()
        }

        let widthScale = rect.width / max(pointBounds.width, .leastNonzeroMagnitude)
        let heightScale = rect.height / max(pointBounds.height, .leastNonzeroMagnitude)
        let fittingScale = min(widthScale, heightScale)
        let fittedWidth = pointBounds.width * fittingScale
        let fittedHeight = pointBounds.height * fittingScale
        let xOffset = rect.midX - fittedWidth / 2
        let yOffset = rect.midY - fittedHeight / 2

        let fittedPoints = sampledPoints.map { point in
            CGPoint(
                x: xOffset + (point.x - pointBounds.minX) * fittingScale,
                y: yOffset + (point.y - pointBounds.minY) * fittingScale
            )
        }

        var path = Path()
        guard let firstPoint = fittedPoints.first else {
            return path
        }

        path.move(to: firstPoint)

        for point in fittedPoints.dropFirst() {
            path.addLine(to: point)
        }
        
        return path
    }
}
