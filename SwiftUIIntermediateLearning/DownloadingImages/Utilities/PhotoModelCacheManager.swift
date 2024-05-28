//
//  PhotoModelCacheManager.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 28/05/2024.
//

import Foundation

class PhotoModelCacheManager {
    static let instance = PhotoModelCacheManager()
    private init() { }
    
    var photoCache = NSCache<NSString, NSData>()
}
