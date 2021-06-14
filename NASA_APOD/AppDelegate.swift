//
//  AppDelegate.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var coordinator: Coordinator?
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let navigationController = UINavigationController()
    coordinator = Coordinator(navigationController: navigationController)
    coordinator?.start()

    // create a basic UIWindow and activate it
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}

