//
//  AppDelegate.swift
//  cy_swift
//
//  Created by yunan on 2022/4/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CYHomeViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

