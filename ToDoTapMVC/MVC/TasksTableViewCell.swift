//
//  TasksTableViewCell.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 04.06.2021.
//

import UIKit
import PinLayout

class TasksTableViewCell : UITableViewCell {
    
    private let taskForThe = UILabel()
    private let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [taskForThe, iconImageView].forEach{
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin
            .horizontally(12)
            .vertically(18)
        
        taskForThe.pin
            .bottom(8)
            .left(26)
            .height(40)
            .sizeToFit(.height)
        
        iconImageView.pin
            .bottom(16)
            .size(24)
//            .left(of: taskForThe)
            .left(of: taskForThe, aligned: .center)
            .marginLeft(12)
        
    }
    
}
