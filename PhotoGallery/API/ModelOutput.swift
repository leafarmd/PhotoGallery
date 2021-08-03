//
//  Output.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import Foundation

// MARK: - SizesOutput
struct SizesOutput: Decodable {
    let sizes: Sizes
    let stat: String
}

// MARK: - Sizes
struct Sizes: Decodable {
    let canblog: Int
    let canprint: Int
    let candownload: Int
    let size: [Size]
}

// MARK: - Size
struct Size: Decodable {
    let label: String
    let width: Int
    let height: Int
    let source: String
    let url: String
    let media: String
}

// MARK: - PhotosOutput
struct PhotosOutput: Decodable {
    let photos: Photos
}

// MARK: - Photos
struct Photos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
