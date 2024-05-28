//
//  DownloadingImagesBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 23/05/2024.
//

import SwiftUI

// codable
// background threads
// weak self
// combine
// publishers and subscribers
// file manager
// NSCache

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
