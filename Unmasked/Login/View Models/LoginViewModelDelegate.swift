//
//  LoginViewModelDelegate.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func autoSignIn()
    func userNotFound()
    func showSignInFailed(error: CustomError)
    func showSignUpFailed(error: CustomError)
}
