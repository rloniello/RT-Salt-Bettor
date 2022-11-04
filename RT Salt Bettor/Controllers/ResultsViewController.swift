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
    private lazy var bwBackground = BWViewFactory.background(true)
    
    lazy var action: () -> () = {
        self.dismiss(animated: true)
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
    }
    
    
    // MARK: Class Methods
    private func setupSubviews() {
        self.view.addSubview(bwBackground)
        bwBackground.addSubview(matchResults)
        
        matchResults.okButtonAction = action
        matchResults.translatesAutoresizingMaskIntoConstraints = false
        bwBackground.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            bwBackground.topAnchor.constraint(equalTo: guide.topAnchor),
            bwBackground.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            bwBackground.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bwBackground.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            matchResults.topAnchor.constraint(equalTo: bwBackground.topAnchor, constant: 100),
            matchResults.centerXAnchor.constraint(equalTo: bwBackground.centerXAnchor),
            matchResults.leadingAnchor.constraint(equalTo: bwBackground.leadingAnchor, constant: 10),
            matchResults.trailingAnchor.constraint(equalTo: bwBackground.trailingAnchor, constant: -10),
        ])
    }
    
}
