//
//  UserModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import Foundation

class UserModel {
    
    static let userInstance = UserModel()
    var currentUser: User?
    
    func setUser(user: User) {
        currentUser = user
    }
}
