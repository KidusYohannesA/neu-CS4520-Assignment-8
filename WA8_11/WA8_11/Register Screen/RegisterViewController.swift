//
//  RegisterViewController.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/12/24.
//

import UIKit

class RegisterViewController: UIViewController {
    let registerView = RegisterView()
        
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        registerNewAccount()
    }
}
