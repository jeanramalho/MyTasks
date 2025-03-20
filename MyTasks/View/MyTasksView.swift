//
//  MyTasksView.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import Foundation
import UIKit

class MyTasksView: UIView {
    
    lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = .white
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(tasksTableView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
