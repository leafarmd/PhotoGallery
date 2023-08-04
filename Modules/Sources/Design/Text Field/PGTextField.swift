//
//  PGTextField.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

public final class PGTextField: UITextField {
    
    public override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        backgroundColor = PGColor.white64.uiColor
        tintColor = .black
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: .x44),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: .margin),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -.margin)
        ])
    }
}
