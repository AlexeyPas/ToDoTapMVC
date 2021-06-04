//  MainView.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import UIKit
import PinLayout
import Firebase

class TomorrowTable: UIViewController {

    private let tableView = UITableView()

    private  let taskForTomorrow = [
        Tasks(taskForThe: "купить курицу", systemImageName: "checkmark.circle.fill"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapExitButton))
        title = "Tomorrow"
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
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
}

extension TomorrowTable: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return taskForTomorrow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            return .init()
        }
        
        cell.configure(with: taskForTomorrow[indexPath.row])
        
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


