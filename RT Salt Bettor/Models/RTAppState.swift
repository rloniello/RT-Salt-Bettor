//
//  RTAppState.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import Foundation

/// An object that represents user-defined values that can be saved and restored from launch to lauch.
struct RootViewControllerState: Codable {
    var mmr: String
    var ommr: String
    var race: BWRace
}
