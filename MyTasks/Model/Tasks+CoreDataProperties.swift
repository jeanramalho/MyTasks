//
//  Tasks+CoreDataProperties.swift
//  MyTasks
//
//  Created by Jean Ramalho on 20/03/25.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var task: String?
    @NSManaged public var dataHora: Date?

}

extension Tasks : Identifiable {

}
