//
//  RootViewController.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class RootViewController: UIViewController {
    
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
    
    private func setupSubviews() {
        self.view.addSubview(bwScrollView)
        
        matchEntryView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    @objc private func showCredits() {
        let creditsVC = CreditsViewController()
        self.present(creditsVC, animated: true)
    }
    
    @objc private func showResults() {
        let resultsVC = ResultsViewController()
        self.present(resultsVC, animated: true)
    }
    
}
