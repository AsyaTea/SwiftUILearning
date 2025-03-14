//
//  CacheBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 21/05/2024.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    let imageName: String = "Framboos"
    let manager = CacheManager.instance
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage = ""
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got from cache!"
        } else {
            infoMessage = "Image not found in cache!"
        }
    }
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundStyle(Color.purple)
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    })
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.red)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    })
                }
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                })
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Spacer()
                
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    CacheBootcamp()
}
