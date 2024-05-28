//
//  ImageLoadingViewModel.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 28/05/2024.
//

import Foundation
import Combine
import SwiftUI

class ImageLoadingViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var image: UIImage? = nil
    
    var cancellables = Set<AnyCancellable>()
    let urlString: String
    
    init(url: String) {
        urlString = url
        downloadImage()
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
