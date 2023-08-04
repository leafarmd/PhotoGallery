//
//  PGImageGalleryViewController.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 04/08/21.
//

import UIKit
import Design

final class PGImageGalleryViewController: SearchViewContrller {
    
    private let collectionViewContainer = UIView()
    private var datasource: [String] = []
    private var collectionView: UICollectionView?
    private let presenter: PGImageGalleryPresenter
    
    
    init(presenter: PGImageGalleryPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        presenter.setViewModel(self)
        
        searchBarButtonAction = { [presenter] searchBar in
            guard let text = searchBar.searchTextField.text else { return }
            presenter.searchForTag(tags: text)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionViewContainer)
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .x16
        layout.itemSize = CGSize(width: .midWidth, height: .midWidth)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionViewContainer.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor)
        ])
        
        collectionView.register(
            PGImageGalleryCollectionViewCell.self,
            forCellWithReuseIdentifier: PGImageGalleryCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.reloadData()
        
        self.collectionView = collectionView
    }
}

extension PGImageGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PGImageGalleryCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PGImageGalleryCollectionViewCell
        cell?.setupCell(datasource[indexPath.row])
        presenter.currentIndex(indexPath.row)
        return cell ?? PGImageGalleryCollectionViewCell()
    }
}

extension PGImageGalleryViewController: PGImageGalleryViewModel {
    func setSearchBarPlaceHolder(_ text: String) {
        searchController.searchBar.placeholder = text
    }
    
    func presentError(message: String, title: String, actionTitle: String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setTitle(_ text: String) {
        title = text
    }
    
    func addDatasource(_ datasource: [String]) {
        self.datasource.append(contentsOf: datasource)
        collectionView?.reloadData()
    }
    
    func showLoader() {
        PGLoader.shared.showSpinner()
        disableSearchField()
    }
    func hideLoader() {
        PGLoader.shared.removeSpinner()
        enableSearchField()
    }
    
    func clearDataSource() {
        datasource.removeAll()
    }
}
