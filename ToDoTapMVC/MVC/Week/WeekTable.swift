//
//  WeekTable.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 05.06.2021.
//

import UIKit
import PinLayout
import Firebase
import FirebaseDatabase


class WeekTable: UIViewController {
    
    private let tableView = UITableView()

    private var tasks: [taskForDay] =  [   taskForDay(titel: "позвонить", isCompleted: false),
                                              taskForDay(titel: "Дописать", isCompleted: false),
                                              taskForDay(titel: "Убрать", isCompleted: false)
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
        let task =  taskForDay(titel: "Окучить", isCompleted: false)

        tasks.insert(task, at: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
        tableView.endUpdates()
        tableView.reloadData()
    }

    @objc
    private func didTapExitButton() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    private func addItem(nameItem: String, isComleted: Bool = false) {
        tasks.append(taskForDay(titel: nameItem, isCompleted: isComleted))
        saveData()
    }

    private func changeState(at item: Int) -> Bool {
        tasks[item].isCompleted = !tasks[item].isCompleted
        saveData()
        return tasks[item].isCompleted
    }

    private func removeItem(at index: Int) {
        tasks.remove(at: index)
        saveData()
    }

    private func saveData() {
        
    }

    private func loadData() {
        
    }
}

extension WeekTable: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            return .init()
        }
        
        let currentItem = tasks[indexPath.row]
        cell.textLabel?.text = currentItem.titel
        
        if currentItem.isCompleted{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }

    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
