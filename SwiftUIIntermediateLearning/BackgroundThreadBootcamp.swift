//
//  BackgroundThreadBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 13/05/2024.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK 1:     \(Thread.isMainThread)")
            print("CHECK 1:     \(Thread.current)")

            DispatchQueue.main.async {
                self.dataArray = newData
                
                print("CHECK 2:     \(Thread.isMainThread)")
                print("CHECK 2:     \(Thread.current)")

            }
        }
        
        
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(Color.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
