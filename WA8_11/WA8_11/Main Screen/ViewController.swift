//
//  ViewController.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/11/24.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    
    var messageList = [Chat]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
        
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
            handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
                if user == nil{
                    //MARK: not signed in...
                    self.currentUser = nil
                    self.mainScreen.labelText.text = "Please sign in to see your messages!"
                    self.mainScreen.floatingButtonAddContact.isEnabled = false
                    self.mainScreen.floatingButtonAddContact.isHidden = true
                    
                    //MARK: Reset tableView...
                    self.messageList.removeAll()
                    self.mainScreen.tableViewContacts.reloadData()
                    
                    //MARK: Sign in bar button...
                    self.setupRightBarButton(isLoggedin: false)
                    
                }else{
                    //MARK: the user is signed in...
                    self.currentUser = user
                    self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                    self.mainScreen.floatingButtonAddContact.isEnabled = true
                    self.mainScreen.floatingButtonAddContact.isHidden = false
                    //MARK: Logout bar button...
                    self.setupRightBarButton(isLoggedin: true)

                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainScreen

        
        title = "My Messages"
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewContacts.delegate = self
        mainScreen.tableViewContacts.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewContacts.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddContact)
        
        //MARK: tapping the floating add contact button...
        mainScreen.floatingButtonAddContact.addTarget(self, action: #selector(addChatButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
    }
    
    @objc func addChatButtonTapped(){
        let createChatAlert = UIAlertController(
            title: "Enter recipients email",
            message: "Who do you want to chat with?",
            preferredStyle: .alert)
        
        //MARK: setting up email textField in the alert...
        createChatAlert.addTextField{ textField in
            textField.placeholder = "Enter email"
            textField.contentMode = .center
            textField.keyboardType = .emailAddress
        }
        
        //MARK: Sign In Action...
        let createChatAction = UIAlertAction(title: "Create chat", style: .default, handler: {(_) in
            if let email = createChatAlert.textFields![0].text{
                //MARK: TODO, displaying the chat screen
                //let ChatViewController = ChatViewController()
                //self.navigationController?.pushViewController(ChatViewController, animated: true)
            }
        })
        
        //MARK: action buttons...
        createChatAlert.addAction(createChatAction)
        
        self.present(createChatAlert, animated: true, completion: {() in
            //MARK: hide the alerton tap outside...
            createChatAlert.view.superview?.isUserInteractionEnabled = true
            createChatAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
}
