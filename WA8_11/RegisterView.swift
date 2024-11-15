//
//  RegisterView.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/12/24.
//

import UIKit

class RegisterView: UIView {
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textRepeatPassword: UITextField!
    var buttonRegister: UIButton!
    
        override init(frame: CGRect){
            super.init(frame: frame)
            self.backgroundColor = .white
            setuptextFieldName()
            setuptextFieldEmail()
            setuptextFieldPassword()
            setupbuttonRegister()
            setupRepeatPassword()
            
            initConstraints()
        }
        
        func setuptextFieldName(){
            textFieldName = UITextField()
            textFieldName.placeholder = "Name"
            textFieldName.keyboardType = .default
            textFieldName.borderStyle = .roundedRect
            textFieldName.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textFieldName)
        }
        
        func setupRepeatPassword(){
            textRepeatPassword = UITextField()
            textRepeatPassword.placeholder = "Repeat Password"
            textRepeatPassword.textContentType = .password
            textRepeatPassword.isSecureTextEntry = true
            textRepeatPassword.borderStyle = .roundedRect
            textRepeatPassword.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textRepeatPassword)
    }
        
        func setuptextFieldEmail(){
            textFieldEmail = UITextField()
            textFieldEmail.placeholder = "Email"
            textFieldEmail.keyboardType = .emailAddress
            textFieldEmail.borderStyle = .roundedRect
            textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textFieldEmail)
        }
        
        func setuptextFieldPassword(){
            textFieldPassword = UITextField()
            textFieldPassword.placeholder = "Password"
            textFieldPassword.textContentType = .password
            textFieldPassword.isSecureTextEntry = true
            textFieldPassword.borderStyle = .roundedRect
            textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textFieldPassword)
        }
        
        func setupbuttonRegister(){
            buttonRegister = UIButton(type: .system)
            buttonRegister.setTitle("Register", for: .normal)
            buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
            buttonRegister.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonRegister)
        }
        
        func initConstraints(){
            NSLayoutConstraint.activate([
                textFieldName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                textFieldName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
                
                textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
                textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                textFieldEmail.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
                
                textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
                textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                textFieldPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
                
                textRepeatPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
                textRepeatPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                textRepeatPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
                
                buttonRegister.topAnchor.constraint(equalTo: textRepeatPassword.bottomAnchor, constant: 32),
                buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
