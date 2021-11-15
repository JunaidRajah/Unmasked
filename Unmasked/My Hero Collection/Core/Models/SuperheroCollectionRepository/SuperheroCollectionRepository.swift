//
//  SuperheroCollectionRepository.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/11.
//

import Foundation
import Firebase

class SuperheroCollectionRepository: UserRepositoryFetchable {

    private var ref = Database.database().reference()
    private var handle: AuthStateDidChangeListenerHandle?
    private var refObservers: [DatabaseHandle] = []
    
    func addHero(with name: String, heroToSave: [String : String]) {
        handle = FirebaseAuth.Auth.auth().addStateDidChangeListener { _, currentUser in
            if currentUser == nil {
                return
            } else {
                self.ref.child(currentUser!.uid).child("heroes").child(name).setValue(heroToSave)
            }
        }
    }
    
    func signOut(completion: @escaping databaseResult) {
        guard Auth.auth().currentUser != nil else { return }
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func fetchUser(completion: @escaping userResult) {
        handle = FirebaseAuth.Auth.auth().addStateDidChangeListener { _, user in
            if let safeUser = user {
                completion(.success(safeUser))
            } else {
                let userError = CustomError.userNotFound
                completion(.failure(userError))
            }
        }
    }
    
    func removeUserListener() {
        guard let handle = handle else { return }
        FirebaseAuth.Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func signInUser(withEmail email: String, password: String, completion: @escaping userResult) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let loginError = error, user == nil {
                completion(.failure(loginError))
            }
        }
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping userResult) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let signUpError = error {
                completion(.failure(signUpError))
            } else {
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password)
            }
        }
    }
    
    func fetchUserHeroCollection(completion: @escaping userCollectionResult) {
        handle = Auth.auth().addStateDidChangeListener { _, currentUser in
            if currentUser == nil {
                let userError = CustomError.userNotFound
                completion(.failure(userError))
            } else {
                let completed = self.ref.child(currentUser!.uid).child("heroes").observe(.value) { snapshot in
                    var newItems: [superheroCollectionModel] = []
                    for child in snapshot.children {
                        if
                            let snapshot = child as? DataSnapshot,
                            let hero = superheroCollectionModel(snapshot: snapshot) {
                            newItems.append(hero)
                        }
                    }
                    completion(.success(newItems))
                }
                self.refObservers.append(completed)
            }
        }
    }
}
