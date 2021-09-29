//
//  PGImageGalleryCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit
import PGExtensions

final class PGImageGalleryCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String { String(describing: self) }
    let imageView = UIImageView()
    
    func setupCell(_ id: String) {
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        imageView.downloadImageFromUrl(.image(id: id))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
