//
//  UserDefaults.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import Foundation

extension UserDefaults {
    
    /// A basic codable object representing the root view controllers state.
    var applicationState: RootViewControllerState? {
        get {
            guard let userData = self.object(forKey: #function) as? Data else { return nil }
            return try? JSONDecoder().decode(RootViewControllerState.self, from: userData)
        }
        set {
            let functionName = #function
            guard let newUser = newValue else { return }
            if let userData = try? JSONEncoder().encode(newUser) {
                self.set(userData, forKey: functionName)
            }
        }
    }
    
}
