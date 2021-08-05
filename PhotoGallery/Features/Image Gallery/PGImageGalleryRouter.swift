//
//  PGImageGalleryRouter.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 05/08/21.
//

import UIKit

final class PGImageGalleryRouter: PGImageGalleryRouterInterface {
    var navigator: UINavigationController?
    
    func start() {
        let presenter = PGImageGalleryPresenter()
        let viewController = PGImageGalleryViewController(presenter: presenter)
        
        navigator?.pushViewController(viewController, animated: true)
    }
}
