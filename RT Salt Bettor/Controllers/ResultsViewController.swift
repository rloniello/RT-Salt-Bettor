//
//  ResultsViewController.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class ResultsViewController: UIViewController {
    
    
    // MARK: Properties & Subviews
    let matchResults = MatchResultView()
    
    lazy var action: () -> () = {
        self.dismiss(animated: true)
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBroodwarBackground()
        self.setupSubviews()
    }
    
    
    // MARK: Class Methods
    private func setupBroodwarBackground() {
        self.view.addSubview(BWViewFactory.background(true))
    }
    
    private func setupSubviews() {
        self.view.addSubview(matchResults)
        matchResults.okButtonAction = action
        matchResults.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            matchResults.topAnchor.constraint(equalTo: guide.topAnchor, constant: 100),
            matchResults.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            matchResults.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            matchResults.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
        ])
    }
    
}
