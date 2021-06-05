////
////  MainView.swift
////  ToDoTapMVC
////
////  Created by Pasynkov Alexey on 03.06.2021.
////
//
//import UIKit
//import Foundation
//import PinLayout
//import Firebase
//
//class MainView: UIViewController {
//
//    private let tableView = UITableView()
//
//    private var tasks: [Tasks] = [
//        Tasks(title: "Сегодня", taskForThe: "1", systemImageName: "checkmark.circle")
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddButton))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapExitButton))
//        title = "ToDoTap"
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: "TasksTableViewCell")
//        view.addSubview(tableView)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        tableView.pin
//            .all()
//    }
//
//    @objc
//    private func didTapAddButton() {
//
//        let task =  Tasks(title: "Завтра", taskForThe: "3", systemImageName: "checkmark.circle.fill")
//        tasks.insert(task, at: 0)
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
//        tableView.endUpdates()
//        tableView.reloadData()
//    }
//
//    @objc
//    private func didTapExitButton() {
//        do {
//            try Auth.auth().signOut()
//            AppDelegate.shared.rootViewController.showLoginScreen()
//        } catch  {
//            print(error)
//        }
//    }
//}
//
//extension MainView: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        3
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Сегодня"
//        } else if section == 1 {
//            return "Завтра"
//        } else {
//            return "потом"
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return tasks.count
//        } else  if section == 1 {
//            return tasks.count
//        } else {
//            return tasks.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
//            return .init()
//        }
//
//        cell.configure(with: tasks[indexPath.row])
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let task = tasks[indexPath.row]
//        let viewController = UIViewController()
//        viewController.title = task.title
//        viewController.view.backgroundColor = .systemBackground
//
//        let navigationController = UINavigationController(rootViewController: viewController)
//
//        present(navigationController, animated: true, completion: nil)
//    }
//}


//  MainView.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import UIKit
import Foundation
import PinLayout
import Firebase
import FirebaseDatabase


class MainView: UIViewController {

    private let todayTableButton = UIButton()
    private let stackViewForButton = UIStackView()
    private let tomorrowTableButton = UIButton()
    private let weekTableButton = UIButton()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))
    private let buttinExit = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupButton() {
        
        
     
        todayTableButton.setTitle("Today", for: .normal)
        todayTableButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
        todayTableButton.layer.cornerRadius = 12
        todayTableButton.layer.masksToBounds = true
        todayTableButton.setTitleColor(.black, for: .normal)
        todayTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        tomorrowTableButton.setTitle("Tommorow", for: .normal)
        tomorrowTableButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
        tomorrowTableButton.layer.cornerRadius = 12
        tomorrowTableButton.layer.masksToBounds = true
        tomorrowTableButton.setTitleColor(.black, for: .normal)
        tomorrowTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        weekTableButton.setTitle("Week", for: .normal)
        weekTableButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
        weekTableButton.layer.cornerRadius = 12
        weekTableButton.layer.masksToBounds = true
        weekTableButton.setTitleColor(.black, for: .normal)
        weekTableButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        buttinExit.setTitle("Exit", for: .normal)
        buttinExit.setTitleColor(.black, for: .normal)
        buttinExit.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttinExit.alpha = 0.3
        
        todayTableButton.addTarget(self, action: #selector(didTapTodayTableButton), for: .touchUpInside)
        
        tomorrowTableButton.addTarget(self, action: #selector(didTapTommorowTableButton), for: .touchUpInside)
        
        weekTableButton.addTarget(self, action: #selector(didTapWeekTableButton), for: .touchUpInside)
        
        buttinExit.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
    }
    
    
    private func setup() {
        setupButton()
        [backWindow, buttinExit, todayTableButton,tomorrowTableButton, weekTableButton].forEach { view.addSubview($0)}
    }
    
    @objc
    private func didTapTodayTableButton() {
        AppDelegate.shared.rootViewController.switchToTodayTable()
    }
    
    @objc
    private func didTapTommorowTableButton() {
        AppDelegate.shared.rootViewController.switchToTomorrowTable()
    }
    
    @objc
    private func didTapWeekTableButton() {
        AppDelegate.shared.rootViewController.switchToWeekTable()
    }
    
    @objc
    private func didTapExitButton() {
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error)
        }
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        backWindow.pin.center()
        

        tomorrowTableButton.pin
            .center()
            .height(48)
            .width(90%)
            .maxWidth(250)
            
        todayTableButton.pin
            .above(of: tomorrowTableButton, aligned: .center)
            .marginBottom(12)
            .height(48)
            .width(90%)
            .maxWidth(250)

        weekTableButton.pin
            .below(of: tomorrowTableButton, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)

        buttinExit.pin
            .bottomLeft(24)
            .height(48)
            .width(120)
    }
    
}

