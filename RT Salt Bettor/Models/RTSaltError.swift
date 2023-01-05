//
//  RTSaltError.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import Foundation

// 1) A foundational error type
/// A foundational Error structure that is composable and extendable within the context of this app.
struct RTSaltError<Reason: CustomStringConvertible>: Error, CustomStringConvertible {
    var reason: Reason
    
    var description: String {
        return "\(reason)"
    }
}

// 2) Errors that are interchangable and composable.
/// An Error type to be used as the Reason in RTSaltError
enum DataEntryErrorReason: CustomStringConvertible {
    case mmrTooHigh
    case ommrTooHigh
    case raceNotSelected
    case unknown(String)
    case userError(String)
    
    var description: String {
        switch self {
            case .mmrTooHigh:
                return [
                    "Yeah, Flash would win.",
                    "EZ, YEPP",
                    "Why even ask?",
                    "There Trash, RT's brain is melting",
                ].randomElement()!
            case .ommrTooHigh:
                return [
                "SAY GG",
                "Oof LUL",
                "Buckle up, the salt storm cometh.",
                "He'll probablly say it is cheese."
                ].randomElement()!
            case .raceNotSelected:
                return "Please select a Race"
            case .unknown(let string):
                return "\(string)"
            case .userError(let message):
                return "\(message)"
        }
    }
}

/// An Error type to be used as the Reason in RTSaltError
enum RTApplicationErrorReason: CustomStringConvertible {
    case fatalError(fromAction: String)
    case unsatisfiedPrecondtion(reason: String)
    case unexpectedResult(from: String)
    case userError(message: String)
    
    var description: String {
        switch self {
            case .fatalError(let fromAction):
                return "A fatal error occured while perfoming \(fromAction)"
            case .unsatisfiedPrecondtion(let reason):
                return "A require precondtion of \"\(reason)\" was not met"
            case .unexpectedResult(let found):
                return "An unexpected result was detected: \(found)"
            case .userError(let message):
                return "Error: \(message)"
        }
    }
}

// 3) Phantom Type conformance via foundational error type...
typealias DataEntryError = RTSaltError<DataEntryErrorReason>
typealias RTApplicationError = RTSaltError<RTApplicationErrorReason>

