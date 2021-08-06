//
//  PGImageGalleryPresenterTests.swift
//  PhotoGalleryTests
//
//  Created by Rafael Mendes Damasceno on 06/08/21.
//

import XCTest
@testable import PhotoGallery

class PGImageGalleryPresenterTests: XCTestCase {
    
    private var sut: PGImageGalleryPresenter?
    private var interactor: PGImageGalleryInteractorInputSpy?
    private var viewModel: PGImageGalleryViewModelSpy?
    
    func testPresenter() {
        interactor = PGImageGalleryInteractorInputSpy()
        viewModel = PGImageGalleryViewModelSpy()
        sut = PGImageGalleryPresenter(interactor: interactor!)
        
        // when viewmodel is setted
        sut?.setViewModel(viewModel!)
        
        XCTAssert(viewModel?.setTitleCalled == true)
        XCTAssert(viewModel?.titlePassed == "image.search.title".localized())
        XCTAssert(viewModel?.setSearchBarPlaceHolderCalled == true)
        XCTAssert(viewModel?.searchBarPlaceholderPassed == "image.search.placeholder".localized())
        
        // when tag is searched
        sut?.searchForTag(tags: "tag value")
        XCTAssert(viewModel?.showLoaderCalled == true)
        XCTAssert(viewModel?.clearDatasourceCalled == true)
        XCTAssert(interactor?.fetchDataCalled == true)
        XCTAssert(interactor?.pagePassed == 1)
        XCTAssert(interactor?.tagPassed == "tag value")
        
        // when request succeed
        sut?.fetchDataSucceeded(PhotosOutput.mock)
        
        XCTAssert(viewModel?.hideLoaderCalled == true)
        XCTAssert(viewModel?.addDatasourceCalled == true)
        XCTAssert(viewModel?.datasourcePassed ==
                    [
                        "id value_secret value",
                        "id value_secret value",
                        "id value_secret value",
                        "id value_secret value"
                    ]
        )
        
        // when scroll to last item
        viewModel?.showLoaderCalled = nil
        interactor?.fetchDataCalled = nil
        sut?.currentIndex(1)
        XCTAssert(viewModel?.showLoaderCalled == true)
        XCTAssert(interactor?.fetchDataCalled == true)
        XCTAssert(interactor?.pagePassed == 2)
        XCTAssert(interactor?.tagPassed == "tag value")
    
        // when request failed
        sut?.fetchDataFailed("message value")
        XCTAssert(viewModel?.presentErrorCalled == true)
        XCTAssert(viewModel?.errorTitlePassed == "image.gallery.error.title".localized())
        XCTAssert(viewModel?.errorMessagePassed == "image.gallery.error.message".localized())
        XCTAssert(viewModel?.errorActionTitlePAssed == "image.gallery.error.action".localized())
    }
    
    
        
}

fileprivate class PGImageGalleryViewModelSpy: PGImageGalleryViewModel {
    var setTitleCalled: Bool?
    var titlePassed: String?
    var addDatasourceCalled: Bool?
    var datasourcePassed: [String]?
    var presentErrorCalled: Bool?
    var errorMessagePassed: String?
    var errorTitlePassed: String?
    var errorActionTitlePAssed: String?
    var showLoaderCalled: Bool?
    var hideLoaderCalled: Bool?
    var clearDatasourceCalled: Bool?
    var setSearchBarPlaceHolderCalled: Bool?
    var searchBarPlaceholderPassed: String?
    
    func setTitle(_ text: String) {
        setTitleCalled = true
        titlePassed = text
    }
    
    func addDatasource(_ datasource: [String]) {
        addDatasourceCalled = true
        datasourcePassed = datasource
    }
    
    func presentError(message: String, title: String, actionTitle: String) {
        presentErrorCalled = true
        errorMessagePassed = message
        errorTitlePassed = title
        errorActionTitlePAssed = actionTitle
    }
    
    func showLoader() {
        showLoaderCalled = true
    }
    
    func hideLoader() {
        hideLoaderCalled = true
    }
    
    func clearDataSource() {
        clearDatasourceCalled = true
    }
    
    func setSearchBarPlaceHolder(_ text: String) {
        setSearchBarPlaceHolderCalled = true
        searchBarPlaceholderPassed = text
    }
}

fileprivate class PGImageGalleryInteractorInputSpy: PGImageGalleryInteractorInput {
    var output: PGImageGalleryInteractorOutput?
    var fetchDataCalled: Bool?
    var pagePassed: Int?
    var tagPassed: String?
    
    func fetchData(page: Int, tags: String) {
        pagePassed = page
        tagPassed = tags
        fetchDataCalled = true
    }
}
