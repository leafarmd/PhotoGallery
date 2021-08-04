//
//  PGButton.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

final class PGButton: UIButton {
    
    var touchAction: (() -> Void)?
    
    override func didMoveToSuperview() {
        
        guard let superview  = superview else { return }
        
        backgroundColor = PGColor.primary.uiColor
        layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: .x44),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: .margin),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -.margin)
        ])
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    
    @IBAction func touchUpInside() {
        self.touchAction?()
    }
}

