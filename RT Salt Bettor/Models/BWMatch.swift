//
//  BWMatch.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import Foundation

/// A collection of Broodwar Match Data to be used with CoreML Model.
struct BWMatch {
    var currentMMR: UInt16
    var opponentMMR: UInt16
    var opponentRace: BWRace
}

typealias BWMatchResult = [Int64:Double]
