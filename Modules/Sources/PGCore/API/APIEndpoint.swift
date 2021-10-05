import Foundation

public enum APIEndpoint {
    case photos(tags: String, page: Int)
    case image(id: String)
}

public extension APIEndpoint {
    
    private var baseUrl: String { "https://api.flickr.com/services/rest/" }
    private var baseImgUrl: String { "https://farm6.staticflickr.com/5800/" }
    
    var url: String {
        switch self {
        case .photos: return baseUrl
        case .image(let id): return "\(baseImgUrl)\(id)_q.jpg"
        }
    }
    
    var method: HttpMethod {
        switch  self {
        case .photos, .image: return .GET
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
        case .image: return  [:]
        }
    }
}
