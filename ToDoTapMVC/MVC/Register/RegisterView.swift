//
//  RegisterView.swift
//  ToDoTap
//
//  Created by MacBook Pro on 26.04.2021.
//

import UIKit
import PinLayout
import Firebase
import FirebaseDatabase


class RegisterView: UIViewController {
    
    private let conteinerView = UIView()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))
    private let textHidan = UILabel()
    private let actionButton = UIButton()
    private let usernameWindow = UITextField()
    private let passwordWindow = UITextField()
    private let emailWindow = UITextField()
    private let buttonLogin = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
    }
    
    private func setupLable() {
        textHidan.text = "Register"
        textHidan.font = UIFont.systemFont(ofSize: 36, weight: .bold)
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupButton() {
        actionButton.layer.cornerRadius = 20
        actionButton.layer.masksToBounds = true
        actionButton.backgroundColor = UIColor.blue
        actionButton.setTitle("->", for: .normal)
        
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = UIColor(white: 1, alpha: 0.7)
        buttonLogin.layer.cornerRadius = 12
        buttonLogin.layer.masksToBounds = true
        buttonLogin.setTitleColor(.black, for: .normal)
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        buttonLogin.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setupField() {
        usernameWindow.placeholder = "Username"
        usernameWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        usernameWindow.layer.cornerRadius = 20
        usernameWindow.layer.masksToBounds = true
        
        passwordWindow.placeholder = "Password"
        passwordWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        passwordWindow.layer.cornerRadius = 20
        passwordWindow.layer.masksToBounds = true
        
        emailWindow.placeholder = "Email"
        emailWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        emailWindow.layer.cornerRadius = 20
        emailWindow.layer.masksToBounds = true
    }
    
    private func setup() {
        setupLable()
        setupField()
        setupButton()
        
        [textHidan, usernameWindow, emailWindow, passwordWindow, actionButton].forEach{conteinerView.addSubview($0)}
        [backWindow, conteinerView, buttonLogin].forEach { view.addSubview($0)}
    }
    
    
    
    @objc
    private func didTapActionButton() {
        
        
        let name = usernameWindow.text!
        let password = passwordWindow.text!
        let email = emailWindow.text!
        
        if (!name.isEmpty && !password.isEmpty && !email.isEmpty) {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        
                        let db = Firestore.firestore()
                        var user = [[String: Any]]()
                        
                        
                        uid = result.user.uid
                        nameClient = name
                        emailClient = email
                        let row: Int = 0
                        let line = 0
                        var test = [[Int]]()
//                        test[row][line] = ["test", false]
                        
                        let docRef = db.collection("users").document(uid)
                        docRef.getDocument { (document, error) in
                            //  DispatchQueue.global(qos: .utility).async {
                            if let document = document, document.exists {
                                user.append(document.data()!)
                            } else {
                                print("Document does not exist")
                            }
                            db.collection("users").document(uid).setData([
                                "name": name,
                                "email": email,
                                "uid": uid,
                                "row" : ["test", false],
                                "Today": [row],
                                
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                        }
                        AppDelegate.shared.rootViewController.switchToMainScreen()
                    }
                }
                
            }
        } else {
            showAlert()
        }
        
    }
    
    @objc
    private func didTapLoginButton() {
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        backWindow.pin
            .center()
        
        conteinerView.pin
            .horizontally(24)
        
        textHidan.pin
            .top()
            .sizeToFit()
            .hCenter()
        
        usernameWindow.pin
            .below(of: textHidan, aligned: .center)
            .marginTop(36)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        emailWindow.pin
            .below(of: usernameWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)

        passwordWindow.pin
            .below(of: emailWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        actionButton.pin
            .below(of: passwordWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        buttonLogin.pin
            .topRight()
            .marginTop(100)
            .marginRight(12)
            .height(48)
            .width(120)
        
        conteinerView.pin
            .wrapContent(.vertically)
            .center()
    }
    
}



