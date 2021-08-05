//
//  PGLoader.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 05/08/21.
//

import UIKit

protocol PGLoaderProtocol: AnyObject {
    func showSpinner()
    func removeSpinner()
}

final class PGLoader: PGLoaderProtocol {
    public static let shared = PGLoader()
    var spinnerView: UIView?

    func showSpinner() {
        DispatchQueue.main.async {
            guard let view = UIApplication.shared.windows.first!.rootViewController!.view else { return }
            let spinnerView = UIView.init(frame: view.bounds)
            spinnerView.backgroundColor = PGColor.dark50.uiColor
            var activityIndicator = UIActivityIndicatorView(style: .medium)
            if #available(iOS 13.0, *) {
                activityIndicator = UIActivityIndicatorView.init(style: .large)
            }
            activityIndicator.startAnimating()
            activityIndicator.center = spinnerView.center
            
            spinnerView.addSubview(activityIndicator)
            view.addSubview(spinnerView)
            
            self.spinnerView = spinnerView
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = nil
        }
    }
}
