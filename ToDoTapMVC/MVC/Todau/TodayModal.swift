//
//  TodayModal.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 05.06.2021.
//

import Foundation

var taskForToday : [String] =  [
     "Окучитьqwewqeqwrqwrqwrqwr w rqwrw rkwnfkjnjfnj fb nefknw kf kknwfenjewfnjwnfjwnefjnejwfnjwef   n;ndsnfojnsdfoweofweofldnfs",
     "Подстричься",
     "Укрыть",
]

func addItem(nameItem: String) {
    taskForToday.append(nameItem)
    saveData()
}

func removeItem(at index: Int) {
    taskForToday.remove(at: index)
}

func saveData() {
    
}

func loadData() {
    
}

    
