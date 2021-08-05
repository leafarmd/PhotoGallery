//
//  PGImageGalleryPresenter.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

final class PGImageGalleryPresenter {
    
    private weak var viewModel: PGImageGalleryViewModel?
    private let interactor = PGImageGalleryInteractor()
    private let tags: String
    private var page = 1
    private var pages = 0
    private var total = 0
    private var isLoading = false
    
    init(tags: String) {
        self.tags = tags
    }
    
    func setViewModel(_ viewModel: PGImageGalleryViewModel) {
        self.viewModel = viewModel
        viewModel.setTitle(tags)
        viewModel.showLoader()
        
        interactor.output = self
        interactor.fetchData(page: page, tags: tags)
    }
    
    func currentIndex(_ index: Int) {
        if index >= total - 4  && page < pages && !isLoading {
            page += 1
            viewModel?.showLoader()
            interactor.fetchData(page: page, tags: tags)
            isLoading = true
        }
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
