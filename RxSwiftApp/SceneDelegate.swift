//
//  SceneDelegate.swift
//  RxSwiftApp
//
//  Created by Bartłomiej Lańczyk on 08/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navigationController
        self.window = window
        
    }
}

