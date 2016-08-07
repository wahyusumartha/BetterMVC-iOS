//
//  AppDelegate.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let baseURL = NSURL(string: "http://static.westwing.de")
        let connectable = Connection(url: baseURL!)
        let productController = ProductListController(connectable: connectable)
        let productsViewController = ProductViewController(productsHandler: productController)
        let navigationController = UINavigationController(rootViewController: productsViewController)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

