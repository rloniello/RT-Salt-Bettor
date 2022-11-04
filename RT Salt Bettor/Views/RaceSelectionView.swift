//
//  RaceSelectionView.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

class RaceSelectionView: UIView {
    
    // MARK: Properties
    private var tapTerran: UITapGestureRecognizer!
    private var tapZerg: UITapGestureRecognizer!
    private var tapProtoss: UITapGestureRecognizer!
    
    // MARK: Subviews
    private lazy var highlightedImageView: UIImageView? = nil
    
    lazy var terranImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "terran.png"), highlightedImage: UIImage(named: "terran_highlighted.png"))
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var zergImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "zerg.png"), highlightedImage: UIImage(named: "zerg_highlighted.png"))
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var protossImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "protoss.png"), highlightedImage: UIImage(named: "protoss_highlighted.png"))
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: Initialization
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 360, height: 220.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (frame == .zero) {
            self.frame = CGRect(origin: .zero, size: self.intrinsicContentSize)
        }
        commonInit()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupSubviews()
    }
    
    private func commonInit() {
        tapTerran = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        tapZerg = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        tapProtoss = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        
        terranImageView.addGestureRecognizer(tapTerran)
        zergImageView.addGestureRecognizer(tapZerg)
        protossImageView.addGestureRecognizer(tapProtoss)
    }
    
    private func setupSubviews() {
        self.backgroundColor = UIColor.black
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        
        self.addSubview(terranImageView)
        self.addSubview(zergImageView)
        self.addSubview(protossImageView)
        
        let constraints: [NSLayoutConstraint] = [
            terranImageView.topAnchor.constraint(equalTo: self.topAnchor),
            terranImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30),
            terranImageView.heightAnchor.constraint(equalTo: terranImageView.widthAnchor),
            terranImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            zergImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            zergImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30),
            zergImageView.heightAnchor.constraint(equalTo: zergImageView.widthAnchor),
            zergImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            protossImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            protossImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30),
            protossImageView.heightAnchor.constraint(equalTo: protossImageView.widthAnchor),
            protossImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? UIImageView else {
            return
        }
        
        if (view == self.highlightedImageView) {
            view.isHighlighted = false
            self.highlightedImageView = nil
            return
        }
        else {
            self.highlightedImageView?.isHighlighted = false
            view.isHighlighted = true
            self.highlightedImageView = view
        }
    }
    
    func getRace() -> BWRace? {
        switch (self.highlightedImageView) {
            case protossImageView:
                return .Protoss
            case terranImageView:
                return .Terran
            case zergImageView:
                return .Zerg
            default:
                return nil
        }
    }
    
    func set(race: BWRace) {
        self.highlightedImageView?.isHighlighted = false
        self.highlightedImageView = nil
        switch race {
            case .Terran:
                self.highlightedImageView = terranImageView
            case .Zerg:
                self.highlightedImageView = zergImageView
            case .Protoss:
                self.highlightedImageView = protossImageView
        }
        self.highlightedImageView?.isHighlighted = true
    }
}
