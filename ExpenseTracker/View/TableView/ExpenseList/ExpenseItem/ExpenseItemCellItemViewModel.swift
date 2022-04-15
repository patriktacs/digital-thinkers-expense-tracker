//
//  ExpenseItemCellItemViewModel.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import UIKit
import CoreData

struct ExpenseItemCellItemViewModel {
    var nameText: String
    var categoryImageName: String
    var dateText: String
    var amountText: String

    var id: NSManagedObjectID

    init(expense: Expense, isEuro: Bool, exchangeRate: Double) {
        nameText = expense.title ?? ""

        let category = ExpenseCategory(rawValue: expense.category ?? "unknown") ?? .unknown

        switch category {
        case .food:
            categoryImageName = "cart"
        case .travel:
            categoryImageName = "bus"
        case .bill:
            categoryImageName = "banknote"
        case .sport:
            categoryImageName = "figure.walk"
        default:
            categoryImageName = "questionmark.circle"
        }

        dateText = expense.created?.formatted(date: .abbreviated, time: .omitted) ?? ""
        amountText = isEuro ? "\(String(expense.amount / exchangeRate)) EUR" : "\(expense.amount) HUF"

        id = expense.objectID
    }

    init() {
        nameText = ""
        categoryImageName = ""
        dateText = ""
        amountText = ""
        id = NSManagedObjectID()
    }
}
