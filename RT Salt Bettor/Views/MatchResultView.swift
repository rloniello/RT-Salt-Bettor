//
//  MatchResultView.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

class MatchResultView: UIView {
    
    private lazy var primaryResultLabel: UILabel = {
        let l = UILabel()
        l.accessibilityIdentifier = "MatchResultPrimaryLabel"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor(named: "bwlabel")
        l.textAlignment = .center
        l.text = "???"
        return l
    }()
    
    private lazy var resultsDetailsLabel: UILabel = {
        let l = UILabel()
        l.accessibilityIdentifier = "MatchResultDetailsLabel"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor(named: "bwlabel")
        l.textAlignment = .center
        l.numberOfLines = 2
        l.adjustsFontSizeToFitWidth = true
        l.text = "???"
        return l
    }()
    
    var okButtonAction: ()->() = {}
    
    lazy var okButton: UIButton = BWViewFactory.button()
    
    // MARK: Initialization
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 340, height: 340.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (frame == .zero) {
            self.frame = CGRect(origin: .zero, size: self.intrinsicContentSize)
        }
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        self.accessibilityIdentifier = "MatchResultView"
        self.addSubview(primaryResultLabel)
        self.addSubview(resultsDetailsLabel)
        self.addSubview(okButton)
        
        okButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let constraints: [NSLayoutConstraint] = [
            primaryResultLabel.topAnchor.constraint(equalTo: self.topAnchor),
            primaryResultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            primaryResultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            primaryResultLabel.heightAnchor.constraint(equalToConstant: 60),
            
            resultsDetailsLabel.topAnchor.constraint(equalTo: primaryResultLabel.bottomAnchor, constant: 24.0),
            resultsDetailsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            resultsDetailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            resultsDetailsLabel.heightAnchor.constraint(equalToConstant: 85),
            
            okButton.topAnchor.constraint(equalTo: resultsDetailsLabel.bottomAnchor, constant: 24.0),
            okButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            okButton.heightAnchor.constraint(equalToConstant: 50),
            okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // I could expose these properties but they may be moved outside this view later...
    // I don't want to have to update each one independently.
    // for now, just use a setter / config method.
    func set(primaryLabel: String = "", details: String = "") {
        DispatchQueue.main.async {
            self.primaryResultLabel.text = primaryLabel
            self.resultsDetailsLabel.text = details
        }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        self.okButtonAction()
    }
    
    
    
}

