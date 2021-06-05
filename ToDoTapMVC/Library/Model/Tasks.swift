//
//  Tasks.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 04.06.2021.
//
//
//import Foundation
//
//struct Tasks {
//    let title: String
//    let taskForThe: String
//    let systemImageName: String
////    let checkMark: Bool
//}



//  Tasks.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 04.06.2021.
//

import Foundation

struct taskForDay {
    let titel: String
    var isCompleted: Bool = false
}

var newTask: String? = nil
var haveNewData: Bool = false
var uid = String()
var nameClient = String()
var emailClient = String()

 var tasksForToday: [taskForDay] =  [   taskForDay(titel: "позвонить", isCompleted: false),
                                         taskForDay(titel: "Дописать", isCompleted: false),
                                         taskForDay(titel: "Убрать", isCompleted: false)
]

var tasksForTomorrow: [taskForDay] =  [   taskForDay(titel: "позвонить", isCompleted: false),
                                        taskForDay(titel: "Дописать", isCompleted: false),
                                        taskForDay(titel: "Убрать", isCompleted: false)
]

var tasksForWeek: [taskForDay] =  [   taskForDay(titel: "позвонить", isCompleted: false),
                                        taskForDay(titel: "Дописать", isCompleted: false),
                                        taskForDay(titel: "Убрать", isCompleted: false)
]

