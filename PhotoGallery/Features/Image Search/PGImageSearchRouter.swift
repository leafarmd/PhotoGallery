//
//  PGImageSearchRouter.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

final class PGImageSearchRouter: PGImageSearchRouterInterface {
    var navigator: UINavigationController?
    
    func start() {
        let presenter = PGImageSearchPresenter()
        let viewController = PGImageSearchViewController(presenter: presenter)
        navigator?.pushViewController(viewController, animated: true)
        
        presenter.router = self
    }
    
    func gotoImageGallery(_ value: String) {
        let router = PGImageGalleryRouter(tags: value)
        router.navigator = navigator
        router.start()
    }
}
