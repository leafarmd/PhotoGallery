//
//  File.swift
//  
//
//  Created by Rafael Mendes Damasceno on 29/09/21.
//
import UIKit

open class SearchViewContrller: UIViewController {
    public let searchController = UISearchController(searchResultsController: nil)
    public var searchBarButtonAction: ((UISearchBar) -> Void)?
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) { return nil }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchField()
    }
    
    private func setupSearchField() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    public func enableSearchField() {
        searchController.searchBar.searchTextField.isUserInteractionEnabled = true
    }
    
    public func disableSearchField() {
        searchController.searchBar.searchTextField.isUserInteractionEnabled = false
    }
}

extension SearchViewContrller: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarButtonAction?(searchBar)
    }
}
