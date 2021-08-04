//
//  PGImageSearchProtocols.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

protocol PGImageSearchViewModel: AnyObject {
    func setTitle(_ text: String)
    func setBackgroundImage(_ named: String)
    func setSearchActionTitle(_ text: String)
    func setTextFieldPlaceHolder(_ text: String)
}

protocol PGImageSearchRouterInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func gotoImageGallery(_ value: String)
}
