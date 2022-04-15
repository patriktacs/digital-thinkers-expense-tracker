//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerType {
    func getItems<T: NSManagedObject>(model: T.Type) -> [T]
    func deleteItem<T: NSManagedObject>(item: T)
    func saveContext()
}

public class CoreDataManager: CoreDataManagerType {

    // Private variables

    private var context: NSManagedObjectContext?

    // Init

    init() {
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }

    // Public methods

    public func getItems<T: NSManagedObject>(model: T.Type) -> [T] {
        guard let context = context,
              let items = try? context.fetch(model.fetchRequest()) as? [T] else {
            return []
        }

        return items
    }

    public func deleteItem<T: NSManagedObject>(item: T) {
        guard let context = context else {
            return
        }

        context.delete(item)

        saveContext()
    }

    public func saveContext() {
        guard let context = context else { return }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
