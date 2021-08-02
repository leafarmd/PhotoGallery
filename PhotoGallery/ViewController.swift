//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let api = APICore()
        api.requestObject(from: .photos(tags: "kitten", page: 1), type: PhotosOutput.self) {
            result in
            switch result {
            case .success(let response):
                print(response.photos.photo.first?.id ?? "")
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
}

