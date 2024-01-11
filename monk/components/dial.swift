//
//  dial.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import SwiftUI

struct dial: View {
    private let initialValue: CGFloat
    private let minValue: CGFloat
    private let maxValue: CGFloat
    private let step: CGFloat

    private let scale: CGFloat = 275
    private let indicatorLength: CGFloat = 25
    private var innerScale: CGFloat {
        return scale - indicatorLength
    }
    private var knobScale: CGFloat {
        return innerScale - indicatorLength
    }
    @Binding private var value: CGFloat

    init(initialValue: CGFloat = 100, minValue: CGFloat = 40, maxValue: CGFloat = 220, step: CGFloat = 1, value: Binding<CGFloat> = .constant(100)) {
        self.initialValue = initialValue
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        _value = value
    }

    private func angle(between starting: CGPoint, ending: CGPoint) -> CGFloat {
        let center = CGPoint(x: ending.x - starting.x, y: ending.y - starting.y)
        let radians = atan2(center.y, center.x)
        var degrees = 90 + (radians * 180 / .pi)

        if degrees < 0 {
            degrees += 360
        }

        return degrees
    }

    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .center) {
                Circle().fill(Color("secondaryAccent"))
                    .frame(width: self.innerScale, height: self.innerScale, alignment: .center)
                Circle().fill(Color("secondaryAccent")).shadow(color: Color("background").opacity(0.2), radius: 5, x: 10, y: 10)
                    .shadow(color: Color("brand").opacity(0.4), radius: 3, x: -5, y: -5).frame(width: self.knobScale, height: self.knobScale, alignment: .center)
                Circle().fill(Color("primaryAccent")).frame(width: 10, height: 10).offset(y: -(self.knobScale / 2 - indicatorLength))
                    .rotationEffect(.degrees(CGFloat(((self.value - self.minValue) / self.maxValue) * 360)))
            }
            
                .gesture(
                    DragGesture().onChanged { val in

                        let x: CGFloat = min(max(val.location.x, 0), self.innerScale)
                        let y: CGFloat = min(max(val.location.y, 0), self.innerScale)

                        let ending = CGPoint(x: x, y: y)
                        let start = CGPoint(x: (self.innerScale) / 2, y: (self.innerScale) / 2)

                        let angle = self.angle(between: start, ending: ending)

                        self.value = CGFloat((angle / 360) * self.maxValue) + self.minValue
                    }
                )
                
            Circle()
                .stroke(Color("secondaryAccent"), style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .frame(width: self.scale, height: self.scale, alignment: .center)
            Circle()
                .trim(from: 0, to: (self.value - self.minValue) / self.maxValue)
                .stroke(Color("brand"), style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .rotationEffect(.degrees(-90))
                .frame(width: self.scale, height: self.scale, alignment: .center)
        }
    }
}

#Preview {
    dial()
}
