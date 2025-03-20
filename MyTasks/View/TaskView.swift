//
//  TaskView.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import Foundation
import UIKit

class TaskView: UIView {
    
    lazy var taskTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textView.textColor = .black
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.cornerRadius = 12
        textView.backgroundColor = .white
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar Tarefa", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        return button
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
        addSubview(taskTextView)
        addSubview(saveButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            taskTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            taskTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            taskTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            taskTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            saveButton.topAnchor.constraint(equalTo: taskTextView.bottomAnchor, constant: 12),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
        ])
    }
}
