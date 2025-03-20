//
//  CoreDataManager.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
import CoreData
import UIKit

// classe responsável por gerenciar o core data em todo o app
class CoreDataManager {
    
    // criando um singleton para facilitar acesso à classe sem precisar instanciar várias vezes
    static let shared = CoreDataManager()
    
    // O persistent Container gerencia o banco de dados do core data
    let persistentContainer: NSPersistentContainer
    
    // inicializador privado para evitar múltiplas instancias da classe
    private init(){
        // Nome do arquivo xcdatamodeld que foi criado no projeto
        persistentContainer = NSPersistentContainer(name: "MyTasks")
        
        // Carrega o banco de dados e trata possíveis erros
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Erro ao carregar core data: \(error.localizedDescription)")
            }
        }
    }
    
    // cria uma propriedade que retorna o contexto do core data que é onde salvamoe e buscamos os dados
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Método para salvar alterações no banco de dados
    func salvarContexto(){
        let context = persistentContainer.viewContext
        
        // Verifica se há mudanças no contexto antes de salvar
        if context.hasChanges {
            
            do {
                try context.save()
                print("Dados salvos com sucesso")
            } catch {
                print("Erro ao salvar os dados: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: Salva tasks
    func saveTask(task: String, dataHora: Date) {
        
        let newTask = Tasks(context: context)
        newTask.id = UUID()
        newTask.task = task
        newTask.dataHora = dataHora
        
        salvarContexto()
        
    }
    
    //MARK: Busca tarefa
    func fetchTasks() -> [Tasks] {
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        }catch{
            print("Erro ao localizar tasks: \(error.localizedDescription)")
            return []
        }
    }
    
    //MARK: Atualiza tarefa
    func updateTask(id: UUID, newTask: String, newDate: Date){
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do{
            let tasks = try context.fetch(fetchRequest)
            if let taskToUpdate = tasks.first {
                taskToUpdate.task = newTask
                taskToUpdate.dataHora = newDate
                
                salvarContexto()
            }
        }catch{
            print("Erro ao atualizar tarefa: \(error.localizedDescription)")
        }
    }
    
    //MARK: Deletar uma tarefa
    func deleteTask(id: UUID){
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let tasks = try context.fetch(fetchRequest)
            if let taskToDelete = tasks.first {
                context.delete(taskToDelete)
                salvarContexto()
            }
        } catch {
            print("Erro ao atualizar tarefa: \(error.localizedDescription)")
        }
    }
}
