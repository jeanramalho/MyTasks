//
//  MyTasksViewController.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import Foundation
import UIKit

class MyTasksViewController: UIViewController {
    
    let contentView: MyTasksView = MyTasksView()
    
    lazy var addTaskButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.style = .plain
        button.target = self
        button.action = #selector(addTask)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        setupContentView()
        configureNavigationBar()
        setHierarchy()
        setConstraints()
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
    
    private func setupContentView(){
        
        let taskTableView = contentView.tasksTableView
        self.title = "Task"
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    private func configureNavigationBar(){
        self.title = "My Tasks"
        
        if let navigationbar = navigationController?.navigationBar {
            
            let navigationBarLayout = UINavigationBarAppearance()
            navigationBarLayout.configureWithOpaqueBackground()
            navigationBarLayout.backgroundColor = .systemBlue
            
            let fontAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .heavy)
            ]
            
            navigationBarLayout.titleTextAttributes = fontAttributes
            
            navigationbar.standardAppearance = navigationBarLayout
            navigationbar.scrollEdgeAppearance = navigationBarLayout
            navigationbar.compactAppearance = navigationBarLayout
            
            navigationbar.tintColor = .white
        }
        
        self.navigationItem.rightBarButtonItem = addTaskButton
    }
    
    @objc private func addTask(){
        let taskViewController = TaskViewController()
        self.navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension MyTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
