//
//  MenuViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import UIKit
import Firebase
import UnmaskedEngine

class MenuViewController: UIViewController {
    
    private lazy var menuViewModel = MenuViewModel(delegate: self, collectionRepository: SuperheroCollectionRepository())
    
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
    
    func showSignOutFailed(error: Error) {
        Alert.showSignInFailAlert(on: self, errorMesssage: error.localizedDescription.description)
    }
    
}
