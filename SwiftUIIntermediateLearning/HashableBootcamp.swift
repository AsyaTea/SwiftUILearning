//
//  HashableBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 09/05/2024.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {  //Use ID, if you don't wanna use ID you can conform to Hashable method and create an hash value
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
