//
//  MatchPredictor.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import CoreML

final class MatchPredictor: NSObject {
    
    private var model: RTClassifier? = nil
    
    override init() {
        guard let model = try? RTClassifier(configuration: .init()) else {
            print(RTApplicationError(reason: .fatalError(fromAction: "unable to locate RTClassifier from \(#function)")))
            fatalError()
        }
        self.model = model
    }
    
    
    func predict(match: BWMatch) -> BWMatchResult {
        guard let modelPerdiction = try? model!.prediction(RACE: match.opponentRace.rawValue, MMR: Double(match.currentMMR), OMMR: Double(match.opponentMMR)) else {
            print(RTApplicationError(reason: .fatalError(fromAction: "unable to determine match result from \(match)")))
            fatalError()
        }
        return modelPerdiction.WIN_LOSSProbability
    }
    
    func generatePrimaryOutputText(from result: BWMatchResult) -> String {
        var outputText = "No Result"
        
        guard let winPrediction = result[1] else {
            print(RTApplicationError(reason: .unsatisfiedPrecondtion(reason: "unable to find win rate from \(result)")))
            return outputText
        }
        
        switch (winPrediction) {
            case 0.75...1.0:
                outputText = "Artosis is strongly favored."
                return outputText
            case 0.55...74:
                outputText = "Artosis is slightly favored."
                return outputText
            case 0.45...54:
                outputText = "The match is fairly even."
                return outputText
            case 0.25...44:
                outputText = "Opponent is slightly favored."
                return outputText
            case 0.0...24:
                outputText = "Opponent is strongly favored."
                return outputText
            default:
                print(RTApplicationError(reason: .unexpectedResult(from: "\(#function) should have determined ranged output from 0...1 for \(winPrediction)")))
                return outputText
        }
    }
    
    func generateHumanReadablePrediction(from result: BWMatchResult) -> String {
        var outputText = "Unknown Result"
        
        guard let winning = result[1], let loosing = result[0] else {
            print(RTApplicationError(reason: .unsatisfiedPrecondtion(reason: "unable to find win rate or loss rate in \(result)")))
            return outputText
        }
        
        let winorloss:Int64 = (winning > loosing) ? 1 : 0
        let winlossString = (winorloss == 1) ? "RT Will Win" : "RT Will Lose"
        let confidence: Double = round(result[winorloss]! * 1000) / 10.0
        outputText = winlossString + ",\nConfidence: \(confidence)%"
        if (confidence > 68.9 && confidence < 70) {
            outputText += " Nice!"
        }
        return outputText
    }
    
}
