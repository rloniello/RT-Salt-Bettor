//
//  SceneDelegate.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError()
        }
        window?.windowScene = windowScene
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }


}

