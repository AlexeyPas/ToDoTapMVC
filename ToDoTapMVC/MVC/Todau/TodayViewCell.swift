//
//  TodayViewCell.swift
//  ToDoTapMVC
//
//  Created by Pasynkov Alexey on 05.06.2021.
//

import UIKit

class TodayViewCell: UITableViewCell {
    
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
    
    func configure(with model: taskForDay) {
        
       // let coutnOfTasks = model.taskForThe.count
//        for i in model {
//            taskForThe.text = i.taskForThe
//            iconImageView.image = UIImage(systemName: i.systemImageName)
//        }
        
        taskForThe.text = model.titel
//        iconImageView.image = UIImage(systemName: model.systemImageName)
        
    }
}
