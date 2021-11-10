//
//  LoginViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import Foundation
import Firebase

class LoginViewModel {
    
    private weak var handle: AuthStateDidChangeListenerHandle?
    private weak var delegate: LoginViewModelDelegate?
    
    init(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func initialUserCheck() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.delegate?.userNotFound()
            } else {
                self.delegate?.autoSignIn()
            }
        }
    }
    
    func removeUserStateListener() {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let loginError = error, user == nil {
                self.delegate?.showSignInFailed(error: loginError)
            }
        }
    }
    
    func signUp(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
            } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
            }
        }
    }
}
