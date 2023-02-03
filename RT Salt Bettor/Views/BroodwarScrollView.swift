//
//  BroodwarScrollView.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class BroodwarScrollView: UIView, UIScrollViewDelegate {
    
    // MARK: Subviews
    private lazy var bwbackgroundImageView = BWViewFactory.background()
    
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.accessibilityIdentifier = "ChildScrollView"
        sv.isDirectionalLockEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = false
        return sv
    }()
    
    
    // MARK: Initialization
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
    
    
    // MARK: Class Methods
    private func setupSubviews() {
        self.accessibilityIdentifier = "BroodwarScrollView"
        self.addSubview(bwbackgroundImageView)
        self.addSubview(scrollView)
        
        let constraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 900)
    }
    
    func addScrollableView(_ view: UIView) {
        self.scrollView.addSubview(view)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > 0) {
            scrollView.contentOffset.x = 0
        }
    }
}

