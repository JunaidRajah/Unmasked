//
//  SuperheroCollectionProtocol.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/11.
//

import Foundation
import Firebase

typealias userResult = (Result<FirebaseAuth.User, Error>) -> Void
typealias userCollectionResult = (Result<[superheroCollectionModel], Error>) -> Void
typealias databaseResult = (Result<Bool, Error>) -> Void

protocol UserRepositoryFetchable {
    func fetchUser(completion: @escaping userResult)
    func signInUser(withEmail email: String, password: String, completion: @escaping userResult)
    func createUser(withEmail email: String, password: String, completion: @escaping userResult)
    func fetchUserHeroCollection(completion: @escaping userCollectionResult)
    func signOut(completion: @escaping databaseResult)
    func addHero(with name: String, heroToSave: [String : String])
    func removeUserListener()
}
