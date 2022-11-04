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
    
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupWebkitView()
        self.setupBroodwarBackground()
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
    
    private func setupBroodwarBackground() {
        self.view.addSubview(BWViewFactory.background(true))
    }
    
    private func setupSubviews() {
        
        self.view.addSubview(webkitView)
        webkitView.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            webkitView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 100),
            webkitView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            webkitView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
            webkitView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20)
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
