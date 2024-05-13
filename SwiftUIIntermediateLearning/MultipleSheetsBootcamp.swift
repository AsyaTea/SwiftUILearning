//
//  MultipleSheetsBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 07/05/2024.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

//Ways
// 1 - Use a binding
// 2 - Use multiple .sheets
// 3 - Use $item  (BEST CHOICE)

struct MultipleSheetsBootcamp: View {
    @State var selectedModel: RandomModel? = nil

    var body: some View {
        VStack(spacing: 20) {
            
            ScrollView {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
     
            
           
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }

    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}


/*  MARK: NOTE
 
    - OverlayModal didn't load the correct mode because the sheet was created when the Overlay list appeared, and modifying the mode after would have not worked, now I understand lol.
 
    - You can only have 1 sheet per parent-child hierarchy
 
    - This content is created as soon as the view is loaded
 
 */
