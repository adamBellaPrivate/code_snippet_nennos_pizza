//
//  AppDelegate.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        initialAppStarting()
        return true
    }

}

private extension AppDelegate {
    final func setupAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: AppTheme.navigationBarTint, .font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.heavy)]
        UINavigationBar.appearance().tintColor = AppTheme.navigationBarTint
        UINavigationBar.appearance().barTintColor = AppTheme.navigationBarBackground
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    final func initialAppStarting() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NotificationRootViewController()
        window?.makeKeyAndVisible()
    }
}
