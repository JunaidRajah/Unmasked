//
//  Alerts.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import Foundation
import UIKit

struct Alert {
    
    static let signInFailTitle = "Sign In Failed"
    
    static let signUpFailTitle = "Sign Up Failed"
    
    static let gameFailTitle = "Critical Error"
    static let gameFailMessage = "Multiverse convergence engine has been compromised"
    
    static let searchFailTitle = "Still Masked"
    static let searchFailMessage = "Heroes not yet added to the codex"
    
    static let heroSelectFailTitle = "Hero selected has escaped"
    static let heroSelectFailMessage = "Your connection to the Multiverse convergence engine may be at fault"
    
    static let heroUnlockTitle = "Unmasked"
    static let heroUnlockMessage = "Universe has been added to your Unmasked Collection"
    
    private static func showAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }

    static func showSignInFailAlert(on vc: UIViewController, errorMesssage: String) {
        showAlert(on: vc, with: signInFailTitle, message: errorMesssage)
    }

    static func showSignUpFailAlert(on vc: UIViewController, errorMesssage: String) {
        showAlert(on: vc, with: signInFailTitle, message: errorMesssage)
    }
    
    static func showGameFailAlert(on vc: UIViewController) {
        showAlert(on: vc, with: gameFailTitle, message: gameFailMessage)
    }
    
    static func showSearchFailAlert(on vc: UIViewController) {
        showAlert(on: vc, with: searchFailTitle, message: searchFailMessage)
    }
    
    static func showCollectionHeroSelectFailAlert(on vc: UIViewController) {
        showAlert(on: vc, with: heroSelectFailTitle, message: heroSelectFailMessage)
    }
    
    static func showHeroUnlockAlert(on vc: UIViewController, name: String, publisher: String) {
        showAlert(on: vc, with: "\(name) \(heroUnlockTitle)", message: "\(name) from the \(publisher) \(heroUnlockMessage)")
    }
}


