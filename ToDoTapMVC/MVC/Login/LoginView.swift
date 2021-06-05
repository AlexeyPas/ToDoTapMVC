//
//  LoginView.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import UIKit
import Firebase
import PinLayout


class LoginView: UIViewController {
    
    private let conteinerView = UIView()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))
    private let textHidan = UILabel()
    private let actionButton = UIButton()
    private let emailWindow = UITextField()
    private let passwordWindow = UITextField()
    private let buttonRegister = UIButton()
    private let buttinForgot = UIButton()
    private let blur = UIVisualEffect()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
    }

    enum AuthResult {
        case succses
        case failour(Error)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setup() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

        actionButton.layer.cornerRadius = 20
        actionButton.layer.masksToBounds = true
        actionButton.backgroundColor = UIColor.blue
        actionButton.setTitle("->", for: .normal)
        
        textHidan.text = "Login"
        textHidan.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = UIColor(white: 1, alpha: 0.7)
        buttonRegister.layer.cornerRadius = 12
        buttonRegister.layer.masksToBounds = true
        buttonRegister.setTitleColor(.black, for: .normal)
        buttonRegister.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        buttinForgot.setTitle("Forgot?", for: .normal)
        buttinForgot.setTitleColor(.black, for: .normal)
        buttinForgot.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttinForgot.alpha = 0.3
        
        emailWindow.placeholder = "Email"
        emailWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        emailWindow.layer.cornerRadius = 20
        emailWindow.layer.masksToBounds = true
        emailWindow.leftView = paddingView2
        emailWindow.leftViewMode = .always
        
        passwordWindow.placeholder = "Password"
        passwordWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        passwordWindow.layer.cornerRadius = 20
        passwordWindow.layer.masksToBounds = true
        passwordWindow.leftView = paddingView
        passwordWindow.leftViewMode = .always
//
        buttonRegister.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        [textHidan, emailWindow, passwordWindow, actionButton].forEach{conteinerView.addSubview($0)}
        
        [backWindow, conteinerView, buttonRegister, buttinForgot].forEach { view.addSubview($0)}
    }
    
    @objc
    private func didTapActionButton() {
        let email = emailWindow.text!
        let password = passwordWindow.text!
        
        if (!email.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    if let result = result {
                        uid = result.user.uid
                        
                        AppDelegate.shared.rootViewController.switchToMainScreen()
                    }
                }
            }
        } else  if (email.isEmpty && password.isEmpty)  {
            self.showAlert()
        } else {
            self.showAlert()
        }
    }
    
    @objc
    private func didTapRegisterButton() {
        
        AppDelegate.shared.rootViewController.switchToRegisterScreen()
        
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
        
       
        emailWindow.pin
            .below(of: textHidan, aligned: .center)
            .marginTop(26)
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
        
        buttonRegister.pin
            .topRight()
            .marginTop(100)
            .marginRight(12)
            .height(48)
            .width(120)
        
        buttinForgot.pin
            .bottomLeft(24)
            //.marginLeft(12)
            .height(48)
            .width(120)
        
        conteinerView.pin
            .wrapContent(.vertically)
            .center()
    }

}

