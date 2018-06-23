//
//  AppDelegate.swift
//  GeographicalFactSheet
//
//  Created by Ashok Samal on 23/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow (frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: FactSheetViewController()) //Placed inside the Navigation controller. Provides a Navbar.
        window?.makeKeyAndVisible()
        return true
    }

}

