//
//  PGImageSearchViewController.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit

final class PGImageSearchViewController: UIViewController {
    private let imageBackGround = UIImageView()
    private let textField = PGTextField()
    private let button = PGButton()
    private let presenter: PGImageSearchPresenter
    
    init(presenter: PGImageSearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        setupBackgroundImage()
        setupTextField()
        setupButton()
        
        presenter.setViewModel(viewModel: self)
    }
    
    func setupBackgroundImage() {
        view.addSubview(imageBackGround)
        imageBackGround.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageBackGround.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackGround.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackGround.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackGround.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -.x64),
        ])
    }
    
    func setupButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: .x24)
        ])
        
        button.touchAction = { [weak self] in
            guard let self = self else { return }
            self.presenter.searchAction(self.textField.text)
        }
    }
}

extension PGImageSearchViewController: PGImageSearchViewModel {
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func setBackgroundImage(_ named: String) {
        imageBackGround.image = UIImage(named: named)
    }
    
    func setSearchActionTitle(_ text: String) {
        button.setTitle(text, for: .normal)
    }
    
    func setTextFieldPlaceHolder(_ text: String) {
        textField.placeholder = text
    }
}
