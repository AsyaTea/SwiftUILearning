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
    let manager = PhotoModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloading image now!")
        }
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
                guard let self = self,
                      let image = returnedImage else { return }
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

    }
}
