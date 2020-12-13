//
//  AppDelegate.swift
//  VKPhotos
//
//  Created by Игорь Дикань on 12.12.2020.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authServise: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        self.authServise = AuthService()
        authServise.delegate = self
        setupRootViewController()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

}

// MARK: - Private methods
private extension AppDelegate {
    func setupRootViewController() {
        let authVC: AuthViewController = AuthViewController.loadFromStoryboard()
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }
}

// MARK: - AuthServiceDelegate
extension AppDelegate: AuthServiceDelegate {
    
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiseSignIn() {
        print(#function)
        let feedVC:NewsFeedViewController = NewsFeedViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }
}
