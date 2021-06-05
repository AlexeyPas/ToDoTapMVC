//
//  AddTaskViewController.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 05.06.2021.
//

import UIKit
import Foundation
import PinLayout
import Firebase

class AddTaskViewController: UIViewController {
    
    private let addTaskButton = UIButton()
    private let dayForTask = UITextField()
    private let task = UITextField()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Неправильно выбран день", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupButton() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

        backWindow.pin.center()
        
        addTaskButton.setTitle("Add new task", for: .normal)
        addTaskButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
        addTaskButton.layer.cornerRadius = 12
        addTaskButton.layer.masksToBounds = true
        addTaskButton.setTitleColor(.black, for: .normal)
        addTaskButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        
        dayForTask.placeholder = "Choose which day (Today,Tomorrow,Week)"
        dayForTask.backgroundColor = UIColor(white: 1, alpha: 0.7)
        dayForTask.layer.cornerRadius = 20
        dayForTask.layer.masksToBounds = true
        dayForTask.leftView = paddingView
        dayForTask.leftViewMode = .always
        
        task.placeholder = "Write a new task"
        task.backgroundColor = UIColor(white: 1, alpha: 0.7)
        task.layer.cornerRadius = 20
        task.layer.masksToBounds = true
        task.leftView = paddingView2
        task.leftViewMode = .always
        
        
        addTaskButton.addTarget(self, action: #selector(didTapAddTaskButton), for: .touchUpInside)
        
    }
    
    
    private func setup() {
        setupButton()
        [backWindow, addTaskButton, dayForTask, task].forEach { view.addSubview($0)}
    }
    
    private func updateData() {
        if (dayForTask.text != nil &&  task.text != nil) {
            let new = task.text
            haveNewData = true
            switch dayForTask.text {
            case "Tomorrow", "tomorrow":
                newTask = new
                AppDelegate.shared.rootViewController.switchToTomorrowTable()
            case "Today", "today":
                newTask = new
                AppDelegate.shared.rootViewController.switchToTodayTable()
            case "Week", "week":
                newTask = new
                AppDelegate.shared.rootViewController.switchToWeekTable()
            default:
                showAlert()
            }
        }
    }
    
    @objc
    private func didTapAddTaskButton() {
        updateData()
        AppDelegate.shared.rootViewController.switchToTodayTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dayForTask.pin
            .center()
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        task.pin
            .above(of: dayForTask, aligned: .center)
            .marginBottom(12)
            .height(60)
            .width(90%)
            .maxWidth(250)
        
        addTaskButton.pin
            .below(of: dayForTask, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
    }
    
}
