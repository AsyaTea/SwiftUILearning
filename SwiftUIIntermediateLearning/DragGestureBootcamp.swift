//
//  DragGestureBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 03/05/2024.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("\(offset.width)")
        }
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 200, height: 400)
            .offset(offset)
            .scaleEffect(getScaleAmount())
            .rotationEffect(Angle(degrees: getRotationAmount()))
            .gesture(
                DragGesture()
                    .onChanged { value in //value is CGSize
                        withAnimation(.spring()) {
                            offset = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
            )
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width) //absolute
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureBootcamp()
}
