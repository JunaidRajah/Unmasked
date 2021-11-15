//
//  LoginViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import Foundation
import Firebase

class LoginViewModel {
    
    private weak var delegate: LoginViewModelDelegate?
    private var repository: UserRepositoryFetchable
    
    init(delegate: LoginViewModelDelegate, collectionRepository: UserRepositoryFetchable) {
        self.delegate = delegate
        self.repository = collectionRepository
    }
    
    func initialUserCheck() {
        repository.fetchUser(completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.autoSignIn()
            case .failure(_):
                let userError = CustomError.userNotFound
                self?.delegate?.showSignInFailed(error: userError)
            }
        })
    }
    
    func removeUserStateListener() {
        repository.removeUserListener()
    }
    
    func login(withEmail email: String, password: String) {
        repository.signInUser(withEmail: email, password: password, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.autoSignIn()
            case .failure(_):
                let userError = CustomError.userNotFound
                self?.delegate?.showSignInFailed(error: userError)
            }
        })
    }
    
    func signUp(withEmail email: String, password: String) {
        repository.createUser(withEmail: email, password: password, completion:  { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.autoSignIn()
            case .failure(_):
                let userError = CustomError.signUpFailed
                self?.delegate?.showSignUpFailed(error: userError)
            }
        })
    }
}
