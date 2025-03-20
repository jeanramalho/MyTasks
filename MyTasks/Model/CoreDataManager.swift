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
        persistentContainer = NSPersistentContainer(name: "MyTaks")
        
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
}
