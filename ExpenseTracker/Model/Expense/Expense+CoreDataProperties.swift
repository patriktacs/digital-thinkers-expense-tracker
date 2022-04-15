//
//  Expense+CoreDataProperties.swift
//  
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var created: Date?
    @NSManaged public var category: String?

}
