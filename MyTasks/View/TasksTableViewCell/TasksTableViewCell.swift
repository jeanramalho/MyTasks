//
//  TasksTableViewCell.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import Foundation
import UIKit

class TasksTableViewCell: UITableViewCell {
    
    static let identifier: String = "TasksTableViewCell"
    
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var horaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(taskLabel)
        addSubview(dataLabel)
        addSubview(horaLabel)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            taskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            dataLabel.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 6),
            dataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dataLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            horaLabel.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 6),
            horaLabel.leadingAnchor.constraint(equalTo: dataLabel.trailingAnchor, constant: 8),
            dataLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
}
