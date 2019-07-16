//
//  AppDelegate.swift
//  iOS13Demo
//
//  Created by Patrik Billgert on 2019-07-11.
//  Copyright © 2019 Patrik Billgert. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let navController = UINavigationController(rootViewController: TableViewController())
    navController.navigationBar.prefersLargeTitles = true
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    return true
  }
}

