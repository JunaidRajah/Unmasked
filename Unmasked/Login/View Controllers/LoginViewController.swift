//
//  LoginViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/10.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let userModel = UserModel.userInstance
    
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterEmail.delegate = self
        enterPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        handle = Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.userModel.currentUser = User(uid: user!.uid, email: (user?.email)!)
                self.performSegue(withIdentifier: "LoginToMenu", sender: nil)
                self.enterEmail.text = nil
                self.enterPassword.text = nil
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "Sign In Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
            } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
            }
        }
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
