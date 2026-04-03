//
//  ParametricShapePreview.swift
//  MathShape
//
//  Created by Yanan Li on 2026/4/3.
//

import SwiftUI

struct ParametricShapePreview<S: ParametricShape>: View {
    let shape: S

    @State private var progress = 0.0
    
    var body: some View {
        shape
            .stroke(.fill.tertiary, lineWidth: 4)
            .frame(width: 240, height: 240)
            .foregroundStyle(.fill.quaternary)
            .overlay {
                shape.trim(from: 0, to: progress).stroke(.red, lineWidth: 4)
            }
            .border(.fill)
            .padding()
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    progress = 1
                }
            }
    }
}
