//
//  MenuViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didPressSignOut(_ sender: UIButton) {
        guard Auth.auth().currentUser != nil else { return }
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "mainToLogin", sender: self)
        } catch let error {
            print("Auth sign out failed: \(error)")
        }
    }
}
