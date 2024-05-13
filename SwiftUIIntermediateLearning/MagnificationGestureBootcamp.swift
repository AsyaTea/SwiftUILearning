//
//  MagnificationGestureBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 01/05/2024.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currentAmount + lastAmount)
            .gesture( //Can add any gesture
                MagnificationGesture()
                    .onChanged { value in
                         currentAmount = value - 1
                    }
                    .onEnded { value in
//                        lastAmount += currentAmount
                        withAnimation(.spring()) {
                            currentAmount = 0

                        }
                    }
            )
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
