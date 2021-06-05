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
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if haveNewData {
            let task =  taskForDay(titel: newTask!, isCompleted: false)
            tasksForToday.append(task)
            saveData(task: task)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
            tableView.endUpdates()
            tableView.reloadData()
            
            haveNewData = false
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapExitButton))
        title = "Today"
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: "TasksTableViewCell")
        view.addSubview(tableView)
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin
            .all()
    }
    
    @objc
    private func didTapAddButton() {
        AppDelegate.shared.rootViewController.switchToAddTaskScreen()
    }
    
    @objc
    private func didTapExitButton() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    private func addItem(nameItem: String, isComleted: Bool = false) {
        tasksForToday.append(taskForDay(titel: nameItem, isCompleted: isComleted))
//        saveData(at: )
    }
    
    private func changeState(at item: Int) -> Bool {
        tasksForToday[item].isCompleted = !tasksForToday[item].isCompleted
        //saveData(at: item)
        return tasksForToday[item].isCompleted
    }
    
    private func removeItem(at index: Int) {
        tasksForToday.remove(at: index)
        deleteDataFromFB(at: index)
    }
    
    
    
    private func saveData(task: taskForDay) {
        let washingtonRef = self.db.collection("users").document(uid)
        washingtonRef.updateData([
            "Today" : [tasksForToday.count + 1],
//            [tasks.count + 1] : [task.titel, task.isCompleted],
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    func deleteDataFromFB(at index: Int) {
        let docRef = self.db.collection("reserves")
        docRef.document(uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func changeConfirmationInFB(uid: String,  confirmation: Bool) {
        let docRef = self.db.collection("reserves")
        docRef.document(uid).updateData(confirmation ? ["confirmation" : true] : ["confirmation" : false])  { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    private func loadData() {
        var docRef = self.db.collection("users").document(uid)
        var data = String()
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //data = dataDescription.
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
    }
//        func updateView(dataDescription: <<error type>>) {
//        tasks.removeAll()
//        tasks(addItem(nameItem: dataDescription., isComleted: )
//        }
}
}

extension TodayTable: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tasksForToday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            return .init()
        }
        
        let currentItem = tasksForToday[indexPath.row]
        cell.textLabel?.text = currentItem.titel
        
        if currentItem.isCompleted{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        //saveData()
        
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
           // saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

