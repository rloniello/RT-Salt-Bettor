//
//  CreditsViewController.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit
import WebKit


/// Displays Credits & Acknowledgments from an HTML file in the main Bundle.
final class CreditsViewController: UIViewController {
    
    
    // MARK: Properties & Subviews
    private var webkitView: WKWebView!
    private lazy var bwBackground = BWViewFactory.background(true)
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupWebkitView()
        self.setupSubviews()
        self.loadHTML()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.webkitView = nil
    }
    
    
    // MARK: Class Methods
    private func setupWebkitView() {
        self.webkitView = WKWebView()
        self.webkitView.tintColor = UIColor(named: "bwtext")
        self.webkitView.isOpaque = false
    }
    
    private func setupSubviews() {
        
        self.view.addSubview(bwBackground)
        bwBackground.addSubview(webkitView)
        
        webkitView.translatesAutoresizingMaskIntoConstraints = false
        bwBackground.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            bwBackground.topAnchor.constraint(equalTo: guide.topAnchor),
            bwBackground.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            bwBackground.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bwBackground.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            webkitView.topAnchor.constraint(equalTo: bwBackground.topAnchor, constant: 100),
            webkitView.leadingAnchor.constraint(equalTo: bwBackground.leadingAnchor, constant: 20),
            webkitView.trailingAnchor.constraint(equalTo: bwBackground.trailingAnchor, constant: -20),
            webkitView.bottomAnchor.constraint(equalTo: bwBackground.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadHTML() {
        if let url = Bundle.main.url(forResource: "credits", withExtension: "html") {
            webkitView.load(URLRequest(url: url))
        } else {
            fatalError("unable to find `credits.html` file in main bundle")
        }
    }
    
}
