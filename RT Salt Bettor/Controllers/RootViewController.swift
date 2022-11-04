//
//  RootViewController.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class RootViewController: UIViewController {
    
    // Primary View Controller.. try not to make it fat.
    // Launch Credits with info button from corner?
    // Results automatically pops up from dismissble view controller (modal)
    // when button is pressed.
    
    private var bwScrollView = BroodwarScrollView()
    private lazy var informationButton = BWViewFactory.informationButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        // Capture init, ..continuing programmatically.
        self.setupSubviews() // always last.
    }
    
    private func setupSubviews() {
        self.view.addSubview(bwScrollView)
        
        informationButton.addTarget(self, action: #selector(showCredits), for: .touchUpInside)
        
        bwScrollView.addScrollableView(informationButton)
        
        let constraints: [NSLayoutConstraint] = [
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
    
}
