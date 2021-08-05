//
//  File.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

final class PGImageGalleryInteractor: PGImageGalleryInteractorInput {
    var output: PGImageGalleryInteractorOutput?
    let api: APIProtocols
    
    init(api: APIProtocols = APICore()) {
        self.api = api
    }
    
    func fetchData(page: Int, tags: String) {
        
        api.requestObject(from: .photos(tags: tags, page: page), data: nil, type: PhotosOutput.self) { [weak self]
            result in
            switch result {
            case .success(let response):
                self?.output?.fetchDataSucceeded(response)
            case .failure(let failure):
                self?.output?.fetchDataFailed(failure.message)
            }
        }
    }
}
