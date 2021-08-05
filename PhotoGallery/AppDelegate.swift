//
//  AppDelegate.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let navigator = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        makeViewController()
        return true
    }
    
    private func makeViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = navigator
        window?.makeKeyAndVisible()
        let router = PGImageSearchRouter()
        router.navigator = navigator
        router.start()
    }
    
}

