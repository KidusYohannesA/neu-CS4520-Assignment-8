//
//  RegisterFirebaseManager.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/12/24.
//

import Foundation
import FirebaseAuth
import UIKit

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let repeatedPassword = registerView.textRepeatPassword.text,
           let password = registerView.textFieldPassword.text{
            //Validations....
            if repeatedPassword == password && password.count >= 6 && isValidEmail(email){
                
                Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                    if error == nil{
                        //MARK: the user creation is successful...
                        self.setNameOfTheUserInFirebaseAuth(name: name)
                    }else{
                        //MARK: there is a error creating the user...
                        print(error)
                    }
                })
            }else{
                var text = "The password you have repeated does not match the password you have entered"
                if password.count < 6{
                    text = "The password you have entered is too short"
                }
                if !isValidEmail(email){
                    text = "The email you have entered is not valid"
                }
                let alert = UIAlertController(
                        title: "password does not match",
                        message: "\(text)",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alert, animated: true)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
}
