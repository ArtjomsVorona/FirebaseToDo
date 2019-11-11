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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.alpha = 0.1
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
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
    
    @IBAction func registerBuottonTapped(_ sender: Any) {
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
        //            let userRef = self.ref.child((user?.user.uid)!)
        //            userRef.setValue(["email": user?.user.email])
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
