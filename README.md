# MathShape

`MathShape` is a SwiftUI library that re-implements the mathematical curve loaders from [Math Curve Loaders](https://paidax01.github.io/math-curve-loaders/) as `Shape` types.

## Features

- Pure SwiftUI `Shape` implementations.
- Parametric curve rendering through a shared `ParametricShape` protocol.
- Automatic fitting and centering inside the target rectangle.
- Built-in mathematical curves that work well for loading indicators, decorative motion, and generative UI.
- Customizable shape parameters for several curves.

## Requirements

- Swift 6.0
- iOS 17+
- macOS 14+
- watchOS 10+
- tvOS 17+
- visionOS

## Installation

Add `MathShape` as a Swift Package dependency in Xcode, then import the module where you render your shapes:

```swift
import MathShape
import SwiftUI
```

To use this package in SPM, add the package with your repository URL:

```swift
dependencies: [
    .package(url: "https://github.com/liyanan2004/MathShape.git", branch: "main")
]
```

Then add the product to your target dependencies:

```swift
.target(
    name: "YourFeature",
    dependencies: [
        .product(name: "MathShape", package: "MathShape")
    ]
)
```

## Usage

Because every loader is a `Shape`, you can use standard SwiftUI modifiers such as `stroke`, `trim`, `rotationEffect`, and animation.

```swift
import MathShape
import SwiftUI

struct LoaderView: View {
    @State private var progress = 0.0

    var body: some View {
        Shape.butterflyPhase
            .stroke(.gray.opacity(0.2), lineWidth: 6)
            .overlay {
                Shape.butterflyPhase
                    .trim(from: 0, to: progress)
                    .stroke(.red, style: StrokeStyle(lineWidth: 6, lineCap: .round))
            }
            .frame(width: 180, height: 180)
            .task {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: false)) {
                    progress = 1
                }
            }
    }
}
```

You can also instantiate parameterized shapes directly:

```swift
RoseCurveShape(k: 5)
    .stroke(.pink, lineWidth: 4)
    .frame(width: 160, height: 160)
```

### Custom Parametric Shape

Create a new type that conforms to `ParametricShape`, define its sampling range, and return the `x` and `y` coordinates for each sampled value.

```swift
import MathShape
import SwiftUI

public struct EpicycloidStarShape: ParametricShape {
    public static let sampleCount: Int = 1200
    public static let range: ClosedRange<Double> = 0 ... (2 * .pi)

    public struct Context {
        let orbitRadius: Double
        let rollingAngle: Double
    }

    public let cuspCount: Int
    public let rollingRadius: Double

    private var fixedRadius: Double {
        Double(max(cuspCount, 2) - 1) * rollingRadius
    }

    public init(
        cuspCount: Int = 5,
        rollingRadius: Double = 1
    ) {
        self.cuspCount = max(cuspCount, 2)
        self.rollingRadius = rollingRadius
    }

    public func makeContext(_ angle: Double) -> Context {
        let orbitRadius = fixedRadius + rollingRadius
        let rollingAngle = orbitRadius / rollingRadius * angle

        return Context(
            orbitRadius: orbitRadius,
            rollingAngle: rollingAngle
        )
    }

    public func x(_ angle: Double, context: Context) -> Double {
        context.orbitRadius * cos(angle) - rollingRadius * cos(context.rollingAngle)
    }

    public func y(_ angle: Double, context: Context) -> Double {
        context.orbitRadius * sin(angle) - rollingRadius * sin(context.rollingAngle)
    }
}
```

`ParametricShape` takes care of sampling the curve, computing bounds, scaling it to fit the proposed rectangle, and building the final `Path`.

## Credits

This project is a SwiftUI shape-based reimplementation of [Math Curve Loaders](https://paidax01.github.io/math-curve-loaders/) by paidax01.
