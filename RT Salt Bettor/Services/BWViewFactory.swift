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
    
    /// Generates a Broodwar-like button, Green in outline with the first letter of the text Bold.
    /// Generates an "Ok" button if no title is given.
    /// - Parameter title: The normal title of the button.
    /// - Returns: A UIButton
    static func button(withTitle: String = "") -> UIButton {
        let b = UIButton(configuration: .borderedTinted())
        let color = UIColor(named: "bwbutton")
        b.layer.borderColor = color?.cgColor
        b.layer.borderWidth = 3.0
        b.layer.cornerRadius = 8.0
        b.tintColor = color?.withAlphaComponent(0.8)
        b.translatesAutoresizingMaskIntoConstraints = false
        if let firstChar = withTitle.first {
            let t: NSMutableAttributedString = NSMutableAttributedString(string: "\(firstChar)", attributes: [.font:UIFont.boldSystemFont(ofSize: 14.0)])
            let restOfTitle = withTitle.dropFirst(1)
            let itle: NSAttributedString = NSAttributedString(string: String(restOfTitle), attributes: [.font:UIFont.systemFont(ofSize: 14.0)])
            t.append(itle)
            b.setAttributedTitle(t, for: .normal)
        } else {
            let t: NSMutableAttributedString = NSMutableAttributedString(string: "O", attributes: [.font:UIFont.boldSystemFont(ofSize: 14.0)])
            let itle: NSAttributedString = NSAttributedString(string: "k", attributes: [.font:UIFont.systemFont(ofSize: 14.0)])
            t.append(itle)
            b.setAttributedTitle(t, for: .normal)
        }
        return b
    }
    
    
}
