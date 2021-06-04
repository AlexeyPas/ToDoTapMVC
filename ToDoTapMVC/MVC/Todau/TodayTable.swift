//  TodayTable.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import UIKit
import PinLayout
import Firebase

class TodayTable: UIViewController {

    private let tableView = UITableView()

    private var taskForToday : [Tasks] =  [
        Tasks(taskForThe: "Окучитьqwewqeqwrqwrqwrqwr w rqwrw rkwnfkjnjfnj fb nefknw kf kknwfenjewfnjwnfjwnefjnejwfnjwef   n;ndsnfojnsdfoweofweofldnfs", systemImageName: "checkmark.circle.fill"),
        Tasks(taskForThe: "Подстричься", systemImageName: "checkmark.circle.fill"),
        Tasks(taskForThe: "Укрыть", systemImageName: "checkmark.circle.fill"),
    ]
    


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapExitButton))
        title = "Today"
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

    @objc
    private func didTapAddButton() {

        let task =  Tasks(taskForThe: "Окучить", systemImageName: "checkmark.circle.fill")

        taskForToday.insert(task, at: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
        tableView.endUpdates()
        tableView.reloadData()
    }

    @objc
    private func didTapExitButton() {
            AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    
}

extension TodayTable: UITableViewDelegate, UITableViewDataSource {

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return taskForToday.count
//        } else  if section == 1 {
//            return taskForTomorrow.count
//        } else {
//            return taskForWeek.count
//        }
        return taskForToday.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            return .init()
        }
        
        cell.configure(with: taskForToday[indexPath.row])

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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

