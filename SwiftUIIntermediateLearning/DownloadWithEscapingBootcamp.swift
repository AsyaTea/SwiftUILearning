//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 15/05/2024.
//

import SwiftUI

class DownloadWithEscapingViewModel: ObservableObject {
    
    init() {
        
    }
    
    func getPosts() {
        
        guard let url = URL(string: "") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                print("No data")
                return
            }
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code: \(response.statusCode)")
                return
            }
            
        }
        .resume() //starts the function
    }
}

struct DownloadWithEscapingBootcamp: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
