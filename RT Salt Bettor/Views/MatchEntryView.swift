//
//  MatchEntryView.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class MatchEntryView: UIView {
    
    // MARK: Subviews
    // (In order of appearance.)
    private lazy var artosisImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bozowithshoe.png"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderWidth = 1.0
        iv.layer.borderColor = UIColor(named: "bwtext")?.cgColor
        return iv
    }()
    
    private lazy var artoMMRLabel = BWViewFactory.label(text: "Artosis' MMR")
    
    lazy var currentMMR: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(named: "bwtext")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Artosis' MMR"
        tf.font = UIFont.boldSystemFont(ofSize: 20.0)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private lazy var versusLabel = BWViewFactory.label(text: "vs.")
    
    lazy var opponentMMR: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(named: "bwtext")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Opponent's MMR"
        tf.font = UIFont.boldSystemFont(ofSize: 20.0)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        return tf
    }()
    
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
    
    func setupSubviews() {
        
        let spacing: CGFloat = 12.0
        
        self.addSubview(artosisImageView)
        self.addSubview(artoMMRLabel)
        self.addSubview(currentMMR)
        self.addSubview(versusLabel)
        self.addSubview(opponentMMR)
        
        let constraints: [NSLayoutConstraint] = [
            
            self.widthAnchor.constraint(equalTo: self.heightAnchor),
            
            artosisImageView.widthAnchor.constraint(equalToConstant: 200),
            artosisImageView.heightAnchor.constraint(equalTo: artosisImageView.widthAnchor),
            artosisImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            artoMMRLabel.topAnchor.constraint(equalTo: artosisImageView.bottomAnchor),
            artoMMRLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            artoMMRLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            artoMMRLabel.heightAnchor.constraint(equalToConstant: 30),
            
            currentMMR.topAnchor.constraint(equalTo: artoMMRLabel.bottomAnchor),
            currentMMR.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing * 2),
            currentMMR.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing * 2),
            currentMMR.heightAnchor.constraint(equalToConstant: 35),
            
            versusLabel.topAnchor.constraint(equalTo: currentMMR.bottomAnchor),
            versusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            versusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            versusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            opponentMMR.topAnchor.constraint(equalTo: versusLabel.bottomAnchor),
            opponentMMR.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing * 2),
            opponentMMR.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing * 2),
            opponentMMR.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
