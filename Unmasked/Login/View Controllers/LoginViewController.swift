//
//  LoginViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    private lazy var loginViewModel = LoginViewModel(delegate: self)
    @IBOutlet private weak var enterEmail: UITextField!
    @IBOutlet private weak var enterPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterEmail.delegate = self
        enterPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginViewModel.initialUserCheck()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginViewModel.removeUserStateListener()
    }
    
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        loginViewModel.login(withEmail: email, password: password)
    }
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        loginViewModel.signUp(withEmail: email, password: password)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == enterEmail {
            enterPassword.becomeFirstResponder()
        }
        
        if textField == enterPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func showSignInFailed(error: Error) {
        Alert.showSignInFailAlert(on: self, errorMesssage: error.localizedDescription)
    }
    
    func autoSignIn() {
        self.performSegue(withIdentifier: "LoginToMenu", sender: nil)
        self.enterEmail.text = nil
        self.enterPassword.text = nil
    }
    
    func userNotFound() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
