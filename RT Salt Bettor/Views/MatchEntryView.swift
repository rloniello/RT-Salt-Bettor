//
//  MatchEntryView.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class MatchEntryView: UIView {
    
    // MARK: Properties
    private var typingTimer: Timer?
    
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
        tf.accessibilityIdentifier = "CurrentMMRTextField"
        tf.textColor = UIColor(named: "bwtext")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Artosis' MMR"
        tf.font = UIFont.boldSystemFont(ofSize: 20.0)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.delegate = self
        return tf
    }()
    
    private lazy var versusLabel = BWViewFactory.label(text: "vs.")
    
    lazy var opponentMMR: UITextField = {
        let tf = UITextField()
        tf.accessibilityIdentifier = "OpponentMMRTextField"
        tf.textColor = UIColor(named: "bwtext")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Opponent's MMR"
        tf.font = UIFont.boldSystemFont(ofSize: 20.0)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.delegate = self
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
        self.accessibilityIdentifier = "MatchEntryView"
        let spacing: CGFloat = 12.0
        
        self.addSubview(artosisImageView)
        self.addSubview(artoMMRLabel)
        self.addSubview(currentMMR)
        self.addSubview(versusLabel)
        self.addSubview(opponentMMR)
        
        let constraints: [NSLayoutConstraint] = [
            
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
    
    /// Provides the default text color for the given Match Making Rating (MMR)
    /// - Parameter mmr: The Match Making Rating of the player.
    /// - Returns: A color representing Skill Class or League.
    func textColor(for mmr: Int) -> UIColor {
        switch (mmr) {
                // F
            case 0...1175:
                return UIColor(red: 184/255, green: 183/255, blue: 183/255, alpha: 1)
                // E
            case 1176...1375:
                return UIColor(red: 75/255, green: 210/255, blue: 118/255, alpha: 1)
                // D
            case 1376...1518:
                return UIColor(red: 100/255, green: 215/255, blue: 215/255, alpha: 1)
                // C
            case 1519...1669:
                return UIColor(red: 80/255, green: 130/255, blue: 230/255, alpha: 1)
                // B
            case 1670...1925:
                return UIColor(red: 165/255, green: 25/255, blue: 230/255, alpha: 1)
                // A
            case 1926...2138:
                return UIColor(red: 220/255, green: 60/255, blue: 30/255, alpha: 1)
                // S, S+
            case 2139...Int.max:
                return UIColor(red: 220/255, green: 200/255, blue: 80/255, alpha: 1)
            default:
                return UIColor(red: 184/255, green: 183/255, blue: 183/255, alpha: 1)
        }
    }
    
    
    func getMatchData() -> (mmr: UInt16, ommr: UInt16)? {

        guard let mmrString = self.currentMMR.text, let mmr = UInt16(mmrString) else {
            Hermes.distressing(DataEntryError(reason: .userError("Enter RT's MMR")).description)
            return nil
        }
        
        guard let ommrString = self.opponentMMR.text, let ommr = UInt16(ommrString) else {
            Hermes.distressing(DataEntryError(reason: .userError("Enter Opponent's MMR")).description)
            return nil
        }

        if (mmr > 4000) {
            Hermes.distressing(DataEntryError(reason: .mmrTooHigh).description)
            return nil
        }
        
        if (ommr > 4000) {
            Hermes.distressing(DataEntryError(reason: .ommrTooHigh).description)
            return nil
        }
        
        return (mmr: mmr, ommr: ommr)
    }
    
    private func setTextColor(for textField: UITextField) {
        if let text = textField.text, let intText = Int(text) {
            let color = textColor(for: intText)
            textField.textColor = color
        }
    }
    
}

extension MatchEntryView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.setTextColor(for: textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        self.typingTimer?.invalidate()
        
        self.typingTimer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { [weak self] timer in
            self?.setTextColor(for: textField)
        })
        
        if (string == "") {
            return true
        }
        // Stop more than 4 character input
        if (currentText.count + string.count > 4) {
            return false
        }
        
        return true
    }
}
