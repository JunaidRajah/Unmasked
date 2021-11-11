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
    private var repository: UserRepositoryFetchable
    
    init(delegate: MenuViewModelDelegate, collectionRepository: UserRepositoryFetchable) {
        self.delegate = delegate
        self.repository = collectionRepository
    }
    
    func signOut() {
        repository.signOut(completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.signOut()
            case .failure(let error):
                self?.delegate?.showSignOutFailed(error: error)
            }
        })
    }
}
