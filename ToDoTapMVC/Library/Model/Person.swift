//
//  Person.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import Foundation

class  PersonInfo{
    var fio: String
    var email: String
    var password: String
    
    init(_ fio:String, _ email:String, _ password: String){
        self.fio = fio
        self.email = email
        self.password = password
    }
}

