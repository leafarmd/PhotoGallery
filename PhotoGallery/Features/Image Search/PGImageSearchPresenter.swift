//
//  PGImageSearchPresenter.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import Foundation

final class PGImageSearchPresenter {
    
    private struct Strings {
        static let title: String = "image.search.title".localized()
        static let placeholder: String = "image.search.placeholder".localized()
        static let actionTitle: String = "image.search.action".localized()
    }
    
    private weak var viewModel: PGImageSearchViewModel?
    var router: PGImageSearchRouterInterface?
    
    func setViewModel(viewModel: PGImageSearchViewModel) {
        self.viewModel = viewModel
        
        viewModel.setTitle(Strings.title)
        viewModel.setTextFieldPlaceHolder(Strings.placeholder)
        viewModel.setSearchActionTitle(Strings.actionTitle)
        viewModel.setBackgroundImage(PGImageName.mainBG.rawValue)
    }
    
    func searchAction(_ value: String?) {
        guard let value = value else { return }
        router?.gotoImageGallery(value)
    }
}
