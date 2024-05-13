//
//  ScrollViewReaderBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 03/05/2024.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    var body: some View {
        VStack {
            
            TextField("Enter a number here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll now") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                   
                    ForEach(0..<50) { index in
                        Text("Item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index) //tell the proxy where each item is
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
