//
//  BWRace.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import Foundation

/// A Broodwar Race.
/// https://en.wikipedia.org/wiki/StarCraft:_Brood_War
enum BWRace: String, Codable {
    case Terran = "Terran"
    case Zerg = "Zerg"
    case Protoss = "Protoss"

    static var allCases: [String] {
        return [BWRace.Terran.rawValue, BWRace.Zerg.rawValue, BWRace.Protoss.rawValue]
    }
}
