//
//  AppDelegate.swift
//  MVP Colors
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func makeRootViewController() -> UIViewController {
        
        let networkLayer = NetworkManager()
        let model = ArtworkModel(with: networkLayer)
        let presenter = ArtworkCollectionPresenter(with: model)
        return ArtworkCollectionViewController(with: presenter)
    }
}

