//
//  PGImageGalleryRouter.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 05/08/21.
//

import UIKit

final class PGImageGalleryRouter: PGImageGalleryRouterInterface {
    var navigator: UINavigationController?
    private let tags: String
    
    init(tags: String) {
        self.tags = tags
    }
    
    func start() {
        let presenter = PGImageGalleryPresenter(tags: tags)
        let viewController = PGImageGalleryViewController(presenter: presenter)
        
        navigator?.pushViewController(viewController, animated: true)
    }
}
