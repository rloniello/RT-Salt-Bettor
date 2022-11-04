//
//  Hermes.swift
//
//  Created by Russell on 12/2/20.
//  Copyright © 2020 Russell Loniello. All rights reserved.
//

import UIKit

/// An action that Hermes can present to the user.
enum HermesAction: String {
    case done = "Done"
    case dismiss = "Dismiss"
    case later = "Maybe Later"
    case ollkorrect = "OK"
    case affirmative = "YES"
}

/// The Messenger of the Gods.
/// This class sends alert messages, warnings and such to the user in the standard format.
/// This is a closed, concrete class. Do not attempt to overide, extend or subclass this class.
final class Hermes {
    
    private static var rootViewController: UIViewController? {
        let scene = UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive }) as? UIWindowScene

        return scene?.windows.first(where: { $0.isKeyWindow })?.rootViewController
    }
    
    private init() {}
    
    /// Sends an alert to the user with a title, message and dismiss action.
    /// Use this method to tell the user something directly.
    /// - Parameters:
    ///   - title: A *Short* title of the message.
    ///   - message: A basic message you want to send to the user.
    class func kairosDirectMessage(_ title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: HermesAction.ollkorrect.rawValue, style: .default, handler: nil))
        
        Hermes.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /// Redirects an alert view the root view controller.
    /// - Parameters:
    ///   - alert: The `UIAlertController` to present
    ///   - animated: Bool
    class func relaying(_ alert: UIAlertController, animated: Bool = true) {
        alert.pruneNegativeWidthConstraints()
        Hermes.rootViewController?.present(alert, animated: animated, completion: nil)
    }
    
    // MARK: Class methods
    /// Displays an Error Message to the user.
    /// - Parameters:
    ///   - error: The error string to show the user.
    ///   - message:A possible message you want the user to read.
    ///   - action: An action to perform, see `HermesAction`.
    ///   - completion: A closure that should be ran if the user selects the action.
    class func distressing(_ error: String, message: String? = nil,  action: HermesAction? = nil, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: HermesAction.dismiss.rawValue, style: .default, handler: nil))
        
        if let action = action {
            alert.addAction(UIAlertAction(title: action.rawValue, style: .default, handler: completion))
        }
        
        Hermes.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /// Displays a toast text label with the given message as an alert beneath a top view with 0 spacing.
    /// The apprised alert will disappear after 5 seconds. (removed from super view).
    /// - Parameters:
    ///   - message: A short message
    ///   - backgroundColor: The background color of the text label.
    ///   - textColor: The color of the text's font.
    ///   - topView: The top view whoses `view.frame.minY` will be used to determine the top of the text label.
    class func apprise(message: String, backgroundColor: UIColor = .systemYellow, textColor: UIColor = .label, topView: UIView) {
        if let rootViewController = Hermes.rootViewController {
            let height: CGFloat = 45.0
            let messageView: UILabel = {
                let l = UILabel(frame: CGRect(x: 0, y: topView.frame.minY - height, width: rootViewController.view.frame.width, height: height))
                l.adjustsFontSizeToFitWidth = true
                l.font = UIFont.systemFont(ofSize: 12)
                l.textAlignment = .center
                l.text = message
                l.textColor = textColor
                l.backgroundColor = backgroundColor
                return l
            }()

            rootViewController.view.addSubview(messageView)
            
            UIView.animate(withDuration: 0.3) {
                messageView.center = CGPoint(x: messageView.center.x, y: messageView.center.y + height)
            }
            
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.3) {
                    messageView.center = CGPoint(x: messageView.center.x, y: messageView.center.y - height)
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) { (timer) in
                messageView.removeFromSuperview()
            }
        }
    }
    
}

/*
 There is a breaking constraint bug that can be resolved by removing it prior to presentation.
 https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints/55653274#55653274
 */
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
