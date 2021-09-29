//
//  PhotoGalleryTests.swift
//  PhotoGalleryTests
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import XCTest
import PGCore

@testable import PhotoGallery

class PGImageGalleryInteractorTests: XCTestCase {

    var api: APIStub?
    var sut: PGImageGalleryInteractor?
    var output: PGImageGalleryInteractorOutputSpy?
    
    func testSuccess() throws {
        
        api = APIStub(status: .success(PhotosOutput.mock))
        sut = PGImageGalleryInteractor(api: api!)
        output = PGImageGalleryInteractorOutputSpy()
        sut?.output = output
        
        sut?.fetchData(page: 1, tags: "tag")
        XCTAssert(api?.url == "https://api.flickr.com/services/rest/")
        XCTAssert(api?.params!["page"] == "1")
        XCTAssert(api?.params!["tags"] == "tag")
        XCTAssert(api?.params!["method"] == "flickr.photos.search")
        XCTAssert(output?.fetchDataSucceededCalled == true)
        XCTAssert((output?.photoOutput) != nil)
    }
    
    func testdecodingFailedFailure() throws {
        api = APIStub(status: .failure(.decodingFailed))
        sut = PGImageGalleryInteractor(api: api!)
        output = PGImageGalleryInteractorOutputSpy()
        sut?.output = output
        
        sut?.fetchData(page: 1, tags: "tag")
        XCTAssert(api?.url == "https://api.flickr.com/services/rest/")
        XCTAssert(api?.params!["page"] == "1")
        XCTAssert(api?.params!["tags"] == "tag")
        XCTAssert(api?.params!["method"] == "flickr.photos.search")
        XCTAssert(output?.fetchDataFailedCalled == true)
        XCTAssert(output?.fetchDataFailedMessage == "data decode failed")
        XCTAssert((output?.photoOutput) == nil)
    }
    
    func testdMalformedUrlFailure() throws {
        api = APIStub(status: .failure(.malformedURL))
        sut = PGImageGalleryInteractor(api: api!)
        output = PGImageGalleryInteractorOutputSpy()
        sut?.output = output
        
        sut?.fetchData(page: 1, tags: "tag")
        XCTAssert(api?.url == "https://api.flickr.com/services/rest/")
        XCTAssert(api?.params!["page"] == "1")
        XCTAssert(api?.params!["tags"] == "tag")
        XCTAssert(api?.params!["method"] == "flickr.photos.search")
        XCTAssert(output?.fetchDataFailedCalled == true)
        XCTAssert(output?.fetchDataFailedMessage == "error with URL requested")
        XCTAssert((output?.photoOutput) == nil)
    }
    
    func testdRequestFailedFailure() throws {
        api = APIStub(status: .failure(.requestFailed))
        sut = PGImageGalleryInteractor(api: api!)
        output = PGImageGalleryInteractorOutputSpy()
        sut?.output = output
        
        sut?.fetchData(page: 1, tags: "tag")
        XCTAssert(api?.url == "https://api.flickr.com/services/rest/")
        XCTAssert(api?.params!["page"] == "1")
        XCTAssert(api?.params!["tags"] == "tag")
        XCTAssert(api?.params!["method"] == "flickr.photos.search")
        XCTAssert(output?.fetchDataFailedCalled == true)
        XCTAssert(output?.fetchDataFailedMessage == "error with request")
        XCTAssert((output?.photoOutput) == nil)
    }
    
    func testdInvalidDataFailure() throws {
        api = APIStub(status: .failure(.invalidData))
        sut = PGImageGalleryInteractor(api: api!)
        output = PGImageGalleryInteractorOutputSpy()
        sut?.output = output
        
        sut?.fetchData(page: 1, tags: "tag")
        XCTAssert(api?.url == "https://api.flickr.com/services/rest/")
        XCTAssert(api?.params!["page"] == "1")
        XCTAssert(api?.params!["tags"] == "tag")
        XCTAssert(api?.params!["method"] == "flickr.photos.search")
        XCTAssert(output?.fetchDataFailedCalled == true)
        XCTAssert(output?.fetchDataFailedMessage == "invalid data")
        XCTAssert((output?.photoOutput) == nil)
    }
}

class PGImageGalleryInteractorOutputSpy: PGImageGalleryInteractorOutput {
    var photoOutput: PhotosOutput?
    var fetchDataSucceededCalled: Bool?
    var fetchDataFailedMessage: String?
    var fetchDataFailedCalled: Bool?
    
    func fetchDataSucceeded(_ output: PhotosOutput) {
        photoOutput = output
        fetchDataSucceededCalled = true
    }
    
    func fetchDataFailed(_ message: String) {
        fetchDataFailedMessage = message
        fetchDataFailedCalled = true
    }
}

extension PhotosOutput {
    static var mock: PhotosOutput {
        return PhotosOutput(
            photos: Photos(
                page: 1,
                pages: 2,
                perpage: 4,
                total: 8,
                photo: [
                    Photo(
                        id: "id value",
                        owner: "owner value",
                        secret: "secret value",
                        server: "server value",
                        farm: 0,
                        title: "title",
                        ispublic: 0,
                        isfriend: 0,
                        isfamily: 0
                    ),
                    Photo(
                        id: "id value",
                        owner: "owner value",
                        secret: "secret value",
                        server: "server value",
                        farm: 0,
                        title: "title",
                        ispublic: 0,
                        isfriend: 0,
                        isfamily: 0
                    ),
                    Photo(
                        id: "id value",
                        owner: "owner value",
                        secret: "secret value",
                        server: "server value",
                        farm: 0,
                        title: "title",
                        ispublic: 0,
                        isfriend: 0,
                        isfamily: 0
                    ),
                    Photo(
                        id: "id value",
                        owner: "owner value",
                        secret: "secret value",
                        server: "server value",
                        farm: 0,
                        title: "title",
                        ispublic: 0,
                        isfriend: 0,
                        isfamily: 0
                    )
                ]
            )
        )
    }
}
