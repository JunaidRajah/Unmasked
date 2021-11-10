//
//  MenuViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    private lazy var menuViewModel = MenuViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressSignOut(_ sender: UIButton) {
        menuViewModel.signOut()
    }
}

extension MenuViewController: MenuViewModelDelegate {
    func signOut() {
        performSegue(withIdentifier: "mainToLogin", sender: self)
    }
}
