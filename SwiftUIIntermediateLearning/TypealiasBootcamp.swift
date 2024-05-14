//
//  TypealiasBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 14/05/2024.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    @State var item: TVModel = TVModel(title: "Title", director: "Joe", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")

        }
    }
}

#Preview {
    TypealiasBootcamp()
}
