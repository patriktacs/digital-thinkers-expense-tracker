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
}

public class CoreDataManager: CoreDataManagerType {

    // Private variables

    private var appDelegate: AppDelegate?
    private var context: NSManagedObjectContext?

    // Init

    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
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
        guard let context = context,
              let appdelegate = appDelegate else {
            return
        }

        context.delete(item)

        appdelegate.saveContext()
    }
}
