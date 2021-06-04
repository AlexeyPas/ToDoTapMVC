//
//  WeekTable.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 05.06.2021.
//

import UIKit
import PinLayout
import Firebase

class WeekTable: UIViewController {
    
    private let tableView = UITableView()

    private let taskForWeek = [
        Tasks(taskForThe: "Забрать подарок", systemImageName: "checkmark.circle.fill"),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapExitButton))
        title = "Week"
        
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

    }

    @objc
    private func didTapExitButton() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
}

extension WeekTable: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskForWeek.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            return .init()
        }
        
        cell.configure(with: taskForWeek[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskForWeek[indexPath.row]
        let viewController = UIViewController()
        viewController.title = "Добавить запись"
        viewController.view.backgroundColor = .systemBackground

        let navigationController = UINavigationController(rootViewController: viewController)

        present(navigationController, animated: true, completion: nil)
    }
}
