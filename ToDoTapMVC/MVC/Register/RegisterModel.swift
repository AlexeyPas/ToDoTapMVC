//
//  RegisterModel.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 03.06.2021.
//

import Foundation
import Firebase


protocol  RegisterModelOutput: AnyObject {
    func didLoad()
}

final class RegisterModel {
    weak var output: RegisterModelOutput?
    
    
}
