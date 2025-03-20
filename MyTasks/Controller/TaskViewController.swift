//
//  TaskViewController.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import Foundation
import UIKit

class TaskViewController: UIViewController {
    
    let contentView: TaskView = TaskView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        self.title = "Task"
        setContentView()
        hideKeyboardTouchOut()
        setHierarchy()
        setConstraints()
    }
    
    private func setContentView(){
        contentView.saveButton.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
    }
    
    private func setHierarchy(){
        view.addSubview(contentView)
    }
    
    private func setConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func hideKeyboardTouchOut(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func saveTask(){
        let newTask = contentView.taskTextView.text
        
        CoreDataManager.shared.saveTask(task: newTask ?? "", dataHora: Date())
        
        contentView.taskTextView.text = ""
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
}
