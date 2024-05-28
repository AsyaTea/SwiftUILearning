//
//  PhotoModel.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 25/05/2024.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
