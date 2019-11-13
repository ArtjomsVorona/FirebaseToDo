//
//  LoginViewController.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 09/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let segueIdentifier = "fireSegue"
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var passwordTExtField: DesignableTextField!
    
    override func viewWillLayoutSubviews() {
        self.navigationItem.titleView = nil
        self.navigationItem.title = "Login"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        usernameTextField.text = ""
        passwordTExtField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.alpha = 0.0
        
        ref = Database.database().reference(withPath: "users")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
            }
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 150
            
            let logo = UIImage(named: "fire.png")
            let imageView = UIImageView(image: logo)
            self.navigationItem.titleView = imageView
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 150
        }
    }
    
    @IBAction func loginButtonTapped() {
        guard let email = usernameTextField.text, let password = passwordTExtField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Email/Password incorrect!")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.displayWarningLabel(withText: "Error occured!")
                return
            }
            
            if user != nil {
                self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
                return
            }
            self.displayWarningLabel(withText: "No such user!")
        }
        
    }
    
    @IBAction func registerBuottonTapped(_ sender: UIButton) {
        guard let email = usernameTextField.text, let password = passwordTExtField.text, email != "", password != "" else {
                    displayWarningLabel(withText: "Email/Password incorrect!")
                    return
                }
        Auth.auth().createUser(withEmail: email, password: password, completion:  { (user, error) in
                    guard error == nil, user != nil else {
                        print(error!.localizedDescription)
                        self.displayWarningLabel(withText: "User is not creadted!")
                        return
                    }
                    let userRef = self.ref.child((user?.user.uid)!)
                    userRef.setValue(["email": user?.user.email])
                })
    }
    
    func displayWarningLabel(withText text:String){
           warningLabel.text = text
           UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: { [weak self] in
               self?.warningLabel.alpha = 1
           }) { [weak self] complete in
               self?.warningLabel.alpha = 0
           }
       }

}

//MARK: Extensions

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            textField.resignFirstResponder()
            passwordTExtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
