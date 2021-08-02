//
//  APIEndpoint.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import Foundation

enum APIEndpoint {
    case photos(tags: String, page: Int)
}

extension APIEndpoint {
    
    var baseUrl: String { "https://api.flickr.com/services/rest/" }
    
    var url: String {
        switch self {
        case .photos: return baseUrl
        }
    }
    
    var method: HttpMethod {
        switch  self {
        case .photos: return .GET
        }
    }
    
    
    var params: [String: String] {
        switch self {
        case .photos(let tags, let page):
            return [
                "method": "flickr.photos.search",
                "tags": tags,
                "page": "\(page)"
            ]
        }
    }
}
