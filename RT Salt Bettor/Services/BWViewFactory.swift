//
//  BWViewFactory.swift
//  RT Salt Bettor
//
//  Created by Russell on 11/4/22.
//

import UIKit

final class BWViewFactory: NSObject {
    
    /// Creates a Broodwar Background Image View
    /// - Parameter isCredits: What type of background to show, if true `bwcredits.jpg` is used instead.
    /// - Returns:A UIImage
    static func background(_ isCredits: Bool = false) -> UIImageView {
        if (isCredits) {
            let iv = UIImageView(frame: UIScreen.main.bounds)
            iv.image = UIImage(named: "bwcredits.jpg")
            iv.isUserInteractionEnabled = true
            iv.contentMode = .scaleToFill
            return iv
        } else {
            let iv = UIImageView(image: UIImage(named: "bwbackground.jpg"))
            iv.frame = UIScreen.main.bounds
            iv.isUserInteractionEnabled = true
            return iv
        }
    }
    
    static func informationButton() -> UIButton {
        let b = UIButton(type: .infoLight)
        b.sizeToFit()
        b.tintColor = UIColor(named: "bwbutton")
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }
    
    static func label(text: String, alignment: NSTextAlignment = .center) -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor(named: "bwlabel")
        l.text = text
        l.textAlignment = alignment
        return l
    }

    
}
