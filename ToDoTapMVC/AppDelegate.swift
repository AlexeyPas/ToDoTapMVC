//
//  AppDelegate.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}

//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = RootViewController()
//        window?.makeKeyAndVisible()
//        let window = UIWindow()
//
//        let vc = RegisterView()
//
//        FirebaseApp.configure()
//
//        let navigationController = UINavigationController(rootViewController: vc)
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//
//        self.window = window
//        return true
//    }

// MARK: UISceneSession Lifecycle

//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
//        let rootViewController = self.window!.rootViewController as! UINavigationController
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
//        rootViewController.pushViewController(profileViewController, animated: true)
//        return true
//
func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}

func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}




