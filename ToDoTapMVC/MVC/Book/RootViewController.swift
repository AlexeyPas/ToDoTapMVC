//
//  RootViewController.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 04.06.2021.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)               // 1
        current.view.frame = view.bounds              // 2
        view.addSubview(current.view)                 // 3
        current.didMove(toParent: self) // 4
    }
    
    func showLoginScreen() {
        
        let new = UINavigationController(rootViewController: LoginView())
    
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func switchToMainScreen() {
       let mainViewController = MainView()
       let new = UINavigationController(rootViewController: mainViewController)
        
        animateFadeTransition(to: new)
    }
    
    func switchToRegisterScreen() {
       let registerViewController = RegisterView()
       let new = UINavigationController(rootViewController: registerViewController)
        
        animateFadeTransition(to: new)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
       current.willMove(toParent: nil)
       addChild(new)
       
       transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
       }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()  
       }
    }
    
    func switchToLogout() {
       let loginViewController = LoginView()
       let logoutScreen = UINavigationController(rootViewController: loginViewController)
       animateDismissTransition(to: logoutScreen)
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
       let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
       current.willMove(toParent: nil)
       addChild(new)
       transition(from: current, to: new, duration: 0.3, options: [], animations: {
          new.view.frame = self.view.bounds
       }) { completed in
          self.current.removeFromParent()
          new.didMove(toParent: self)
          self.current = new
          completion?()
       }
    }
}
