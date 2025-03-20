//
//  MyTasksViewController.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import Foundation
import UIKit

class MyTasksViewController: UIViewController {
    
    private let contentView: MyTasksView = MyTasksView()
    private var tasks: [Tasks] = []
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        loadTasks()
    }
    
    private func setup(){
        
        loadTasks()
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
        
        taskTableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.identifier)
        taskTableView.dataSource = self
        taskTableView.delegate = self
        taskTableView.rowHeight = UITableView.automaticDimension
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
    
    private func loadTasks(){
        self.tasks = CoreDataManager.shared.fetchTasks()
        contentView.tasksTableView.reloadData()
    }
    
    @objc private func addTask(){
        let taskViewController = TaskViewController()
        self.navigationController?.pushViewController(taskViewController, animated: true)
    }
    
}

extension MyTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let atualTask = tasks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as? TasksTableViewCell else {return UITableViewCell()}
        
        cell.taskLabel.text = atualTask.task
        
        let dataFormatada = DateFormatter()
        dataFormatada.dateFormat = "dd/MM/yyyy"
        let data = dataFormatada.string(from: atualTask.dataHora ?? Date())
        
        let horaFormatada = DateFormatter()
        horaFormatada.dateFormat = "HH:mm"
        let hora = horaFormatada.string(from: atualTask.dataHora ?? Date())
        
        cell.dataLabel.text = data
        cell.horaLabel.text = hora
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let taskId = tasks[indexPath.row].id else {return}
            //apaga do banco de dados do core data
            CoreDataManager.shared.deleteTask(id: taskId)
            
            //apaga do array local
            tasks.remove(at: indexPath.row)
            
            //apaga a celula com animacao
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }){_ in
                self.loadTasks()
            }
           

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskView = TaskViewController()
        let taskSelected = tasks[indexPath.row].task
        guard let taskId = tasks[indexPath.row].id else {return}
        
        taskView.contentView.taskTextView.text = taskSelected
        taskView.idTask = taskId
        
        self.navigationController?.pushViewController(taskView, animated: true)
    }
    
    
}
