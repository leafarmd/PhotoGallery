//
//  PGImageGalleryPresenter.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import Core
import Extensions

final class PGImageGalleryPresenter {
    
    private weak var viewModel: PGImageGalleryViewModel?
    private let interactor: PGImageGalleryInteractorInput
    private var tags: String = ""
    private var page = 1
    private var pages = 0
    private var total = 0
    private var isLoading = false
    
    init(interactor: PGImageGalleryInteractorInput = PGImageGalleryInteractor()) {
        self.interactor = interactor
    }
    
    func setViewModel(_ viewModel: PGImageGalleryViewModel) {
        self.viewModel = viewModel
        viewModel.setTitle("image.search.title".localized())
        viewModel.setSearchBarPlaceHolder("image.search.placeholder".localized())
        interactor.output = self
    }
    
    func currentIndex(_ index: Int) {
        if index >= total - 4  && page < pages && !isLoading {
            page += 1
            viewModel?.showLoader()
            interactor.fetchData(page: page, tags: tags)
            isLoading = true
        }
    }
    
    func searchForTag(tags: String) {
        page = 1
        total = 0
        pages = 0
        self.tags = tags
        viewModel?.showLoader()
        viewModel?.clearDataSource()
        interactor.fetchData(page: page, tags: tags)
    }
}

extension PGImageGalleryPresenter: PGImageGalleryInteractorOutput {
    func fetchDataSucceeded(_ output: PhotosOutput) {
        total += output.photos.perpage
        pages = output.photos.pages
        isLoading = false
        viewModel?.hideLoader()
        viewModel?.addDatasource(output.photos.photo.map { $0.id + "_" + $0.secret })
    }
    
    func fetchDataFailed(_ message: String) {
        viewModel?.hideLoader()
        viewModel?.presentError(
            message: "image.gallery.error.message".localized(),
            title: "image.gallery.error.title".localized(),
            actionTitle: "image.gallery.error.action".localized()
        )
    }
}
