//
//  UIImageViewExtensions.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

extension UIImageView {
    func downloadImageFromUrl(_ url: APIEndpoint, defaultImage: UIImage? = nil) {
        let api = APICore()
        
        api.loadImage(from: url) {
            result in
            switch result {
            case .success(let image): self.image = image
            case .failure: self.image = defaultImage
            }
        }
    }
}
