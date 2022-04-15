//
//  ExpenseActionService.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import RxCocoa
import CoreData

protocol ExpenseActionServiceType {
    var editedExpenseId: BehaviorRelay<NSManagedObjectID?> { get }
}

class ExpenseActionService: ExpenseActionServiceType {
    var editedExpenseId = BehaviorRelay<NSManagedObjectID?>(value: nil)
}
