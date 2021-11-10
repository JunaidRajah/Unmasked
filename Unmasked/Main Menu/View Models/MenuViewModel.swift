//
//  MenuViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import Foundation
import Firebase

class MenuViewModel {
    
    private weak var delegate: MenuViewModelDelegate?
    
    init(delegate: MenuViewModelDelegate) {
        self.delegate = delegate
    }
    
    func signOut() {
        guard Auth.auth().currentUser != nil else { return }
        do {
            try Auth.auth().signOut()
            delegate?.signOut()
        } catch let error {
            print("Auth sign out failed: \(error)")
        }
    }
}
