//
//  SplashViewController.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 04.06.2021.
//

import UIKit

class SplashViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.white
      view.addSubview(activityIndicator)
      activityIndicator.frame = view.bounds
      activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
      makeServiceCall()
   }
   
    
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()
            
//            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                // navigate to protected page
//                AppDelegate.shared.rootViewController.switchToMainScreen()
//            } else {
                // navigate to login screen
                AppDelegate.shared.rootViewController.switchToLogout()
//            }
        }
    }
    
   
}


