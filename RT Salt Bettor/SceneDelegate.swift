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
            print(RTApplicationError(reason:
                    .fatalError(fromAction: "Failed to cast UIWindowScene from known good UIScene: \(scene.description)")))
            fatalError()
        }
        
        let rootViewController = RootViewController()
        // Attempt Basic State Restoration
        self.loadCurrentState(to: rootViewController)
        window?.windowScene = windowScene
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        saveCurrentState()
    }
    
    
    func saveCurrentState() {
        if let rootViewController = window?.rootViewController as? RootViewController {
            var mmr = rootViewController.matchEntryView.currentMMR.text ?? "2150"
            if (mmr.isEmpty) {
                mmr = "2150"
            }
            var ommr = rootViewController.matchEntryView.opponentMMR.text ?? "2150"
            if (ommr.isEmpty) {
                ommr = "2150"
            }
            let race = rootViewController.raceSelector.getRace() ?? .Terran
            
            let rootVCState = RootViewControllerState(mmr: mmr, ommr: ommr, race: race)
            UserDefaults.standard.applicationState = rootVCState
        }
    }
    
    
    func loadCurrentState(to rootViewController: RootViewController) {
        if let appState = UserDefaults.standard.applicationState {
            rootViewController.raceSelector.set(race: appState.race)
            rootViewController.matchEntryView.currentMMR.text = appState.mmr
            rootViewController.matchEntryView.opponentMMR.text = appState.ommr
        } else {
            // load default values:
            rootViewController.raceSelector.set(race: .Terran)
            rootViewController.matchEntryView.currentMMR.text = "2150"
            rootViewController.matchEntryView.opponentMMR.text = "2150"
        }
    }


}

