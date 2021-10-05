import UIKit
import PGCore

public final class ImageLoader {
    private init() { }
    
    static let shared = ImageLoader()
    let cache = NSCache<NSString, UIImage>()
}

public extension UIImageView {
    func downloadImageFromUrl(_ endpoint: APIEndpoint, defaultImage: UIImage? = nil) {
        
        if let cachedImage = ImageLoader.shared.cache.object(forKey: endpoint.url as NSString) {
            self.image = cachedImage
            return
        }
        
        let api = APICore()
        
        api.loadImage(from: endpoint) {
            result in
            switch result {
            case .success(let image):
                self.image = image
                ImageLoader.shared.cache.setObject(image, forKey: endpoint.url as NSString)
            case .failure:
                self.image = defaultImage
            }
        }
        
    }
}
