//
//  PGImageGalleryProtocols.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 05/08/21.
//

import UIKit
import Core

protocol PGImageGalleryViewModel: AnyObject {
    func setTitle(_ text: String)
    func addDatasource(_ datasource: [String])
    func presentError(message: String, title: String, actionTitle: String)
    func showLoader()
    func hideLoader()
    func clearDataSource()
    func setSearchBarPlaceHolder(_ text: String)
}

protocol PGImageGalleryInteractorOutput: AnyObject {
    func fetchDataSucceeded(_ output: PhotosOutput)
    func fetchDataFailed(_ message: String)
}

protocol PGImageGalleryInteractorInput: AnyObject {
    var output: PGImageGalleryInteractorOutput? { get set }
    func fetchData(page: Int, tags: String)
}

protocol PGImageGalleryRouterInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
}
