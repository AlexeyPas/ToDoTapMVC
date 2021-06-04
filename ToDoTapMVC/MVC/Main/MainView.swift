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

class MainView: UIViewController {

    private let tableView = UITableView()

    private let taskForToday =  [
        Tasks(taskForThe: "Окучить", systemImageName: "checkmark.circle.fill"),
        Tasks(taskForThe: "Подстричься", systemImageName: "checkmark.circle.fill"),
        Tasks(taskForThe: "Укрыть", systemImageName: "checkmark.circle.fill"),
    ]
    private  let taskForTomorrow = [
        Tasks(taskForThe: "купить курицу", systemImageName: "checkmark.circle.fill"),
    ]
    private let taskForWeek = [
        Tasks(taskForThe: "Забрать подарок", systemImageName: "checkmark.circle.fill"),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapExitButton))
        title = "ToDoTap"
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: "TasksTableViewCell")
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.pin
            .all()
    }

//    @objc
//    private func didTapAddButton() {
//
//        let taskForToday =  TasksForToday(taskForThe: "Окучить", systemImageName: "checkmark.circle.fill")
//
//        tasks.insert(taskForToday, at: 0)
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
//        tableView.endUpdates()
//        tableView.reloadData()
//    }

    @objc
    private func didTapExitButton() {
        do {
            try Auth.auth().signOut()
            AppDelegate.shared.rootViewController.showLoginScreen()
        } catch  {
            print(error)
        }
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Сегодня"
        } else if section == 1 {
            return "Завтра"
        } else {
            return "потом"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return taskForToday.count
        } else  if section == 1 {
            return taskForTomorrow.count
        } else {
            return taskForWeek.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            return .init()
        }
        for i in taskForToday {
            cell.configure(with: i)
        }


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let task = tasks[indexPath.row]
//        let viewController = UIViewController()
//        viewController.title = task.title
//        viewController.view.backgroundColor = .systemBackground
//
//        let navigationController = UINavigationController(rootViewController: viewController)
//
//        present(navigationController, animated: true, completion: nil)
    }
}

