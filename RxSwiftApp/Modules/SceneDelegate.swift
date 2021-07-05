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
        let viewModel = MainViewModel()
        let navigationController = UINavigationController(rootViewController: MainViewController(viewModel: viewModel))
        window.rootViewController = navigationController
        self.window = window
        
    }
}

