//
//  RootViewController.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class RootViewController: UIViewController {
    
    private var predictor = MatchPredictor()
    private var bwScrollView = BroodwarScrollView()
    private lazy var informationButton = BWViewFactory.informationButton()
    private lazy var makePerdictionButton = BWViewFactory.button(withTitle: "Let's GAMBA")
    
    private var matchEntryView: MatchEntryView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.matchEntryView = MatchEntryView()
        self.setupSubviews() // always last.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let mmr = matchEntryView.currentMMR.text, let mmrTextAsInt = Int(mmr) {
            matchEntryView.currentMMR.textColor = matchEntryView.textColor(for: mmrTextAsInt)
        }
        
        if let ommr = matchEntryView.opponentMMR.text, let ommrTextAsInt = Int(ommr) {
            matchEntryView.opponentMMR.textColor = matchEntryView.textColor(for: ommrTextAsInt)
        }
    }
    
    private func setupSubviews() {
        self.view.addSubview(bwScrollView)
        
        matchEntryView.translatesAutoresizingMaskIntoConstraints = false
        
        bwScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        informationButton.addTarget(self, action: #selector(showCredits), for: .touchUpInside)
        makePerdictionButton.addTarget(self, action: #selector(showResults), for: .touchUpInside)
        
        bwScrollView.addScrollableView(makePerdictionButton)
        bwScrollView.addScrollableView(matchEntryView)
        // add last: (for Top Z-Position)
        bwScrollView.addScrollableView(informationButton)
        
        let constraints: [NSLayoutConstraint] = [
            
            matchEntryView.topAnchor.constraint(equalTo: bwScrollView.scrollView.topAnchor),
            matchEntryView.leadingAnchor.constraint(equalTo: bwScrollView.leadingAnchor),
            matchEntryView.trailingAnchor.constraint(equalTo: bwScrollView.trailingAnchor),
            
            makePerdictionButton.topAnchor.constraint(equalTo: matchEntryView.bottomAnchor, constant: 50.0),
            makePerdictionButton.widthAnchor.constraint(equalTo: bwScrollView.widthAnchor, multiplier: 0.75),
            makePerdictionButton.centerXAnchor.constraint(equalTo: bwScrollView.centerXAnchor),
            makePerdictionButton.heightAnchor.constraint(equalToConstant: 55.0),
            
            informationButton.topAnchor.constraint(equalTo: bwScrollView.topAnchor, constant: 70),
            informationButton.widthAnchor.constraint(equalToConstant: 44),
            informationButton.heightAnchor.constraint(equalTo: informationButton.widthAnchor),
            informationButton.trailingAnchor.constraint(equalTo: bwScrollView.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func endEditing() {
        self.view.endEditing(true)
    }
    
    @objc private func showCredits() {
        let creditsVC = CreditsViewController()
        self.present(creditsVC, animated: true)
    }
    
    @objc private func showResults() {
        
        if let matchInfo = matchEntryView.getMatchData() {
            let bwmatch = BWMatch(currentMMR: matchInfo.mmr, opponentMMR: matchInfo.ommr, opponentRace: .Terran)
            let result = predictor.predict(match: bwmatch)
            let primaryString = predictor.generatePrimaryOutputText(from: result)
            let detailsString = predictor.generateHumanReadablePrediction(from: result)
            
            let rvcontroller = ResultsViewController()
            rvcontroller.matchResults.set(primaryLabel: primaryString, details: detailsString)
            if let presentor = rvcontroller.presentationController as? UISheetPresentationController {
                presentor.detents = [.medium()]
            }
            
            self.present(rvcontroller, animated: true)
            
        } else {
            // Errors will be processed by matchEntryView. Exit.
            return
        }
    }
    
}
