//
//  CreateExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

protocol CreateExpenseViewModelType {
    var itemViewModel: Observable<CreateExpenseViewItemViewModel> { get }
    var categoryOptions: Observable<[String]> { get }
    var nameValue: BehaviorRelay<String?> { get }
    var amountValue: BehaviorRelay<String?> { get }
    var categoryValue: BehaviorRelay<String?> { get }

    func saveExpense(completion: (ExpenseActionResult) -> ())
}

public class CreateExpenseViewModel: CreateExpenseViewModelType {

    // Public variables

    var itemViewModel: Observable<CreateExpenseViewItemViewModel>
    var categoryOptions: Observable<[String]>

    var nameValue = BehaviorRelay<String?>(value: nil)
    var amountValue = BehaviorRelay<String?>(value: nil)
    var categoryValue = BehaviorRelay<String?>(value: nil)

    // Private variables

    var editedExpenseId = BehaviorRelay<NSManagedObjectID?>(value: nil)

    // Dependencies

    private var coreDataManager: CoreDataManagerType
    private var expenseActionService: ExpenseActionServiceType

    // Init

    init(coreDataManager: CoreDataManagerType,
         expenseActionService: ExpenseActionServiceType) {
        self.coreDataManager = coreDataManager
        self.expenseActionService = expenseActionService

        itemViewModel = Observable.just(CreateExpenseViewItemViewModel())

        categoryOptions = Observable.just(["food",
                                           "travel",
                                           "bill",
                                           "sport"])

        if let editedExpenseId = expenseActionService.editedExpenseId.value,
           let editedExpense = coreDataManager.getItemById(id: editedExpenseId) as? Expense {
            self.editedExpenseId.accept(editedExpenseId)
            expenseActionService.editedExpenseId.accept(nil)
            nameValue.accept(editedExpense.title ?? "")
            amountValue.accept(String(editedExpense.amount))
            categoryValue.accept(editedExpense.category ?? "")
        }
    }

    // Public methods

    public func saveExpense(completion: (ExpenseActionResult) -> ()) {
        if let editedExpenseId = self.editedExpenseId.value,
           let editedExpense = coreDataManager.getItemById(id: editedExpenseId) as? Expense,
           let name = nameValue.value,
           let amount = Double(amountValue.value ?? "0"),
           let category = categoryValue.value {
            editedExpense.title = name
            editedExpense.amount = amount
            editedExpense.category = category

            coreDataManager.saveContext()

            completion(.updateSuccessful)
        } else if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
           let name = nameValue.value,
           let amount = Double(amountValue.value ?? "0"),
           let category = categoryValue.value {
            let newExpense = Expense(context: context)
            newExpense.title = name
            newExpense.amount = amount
            newExpense.category = category
            newExpense.created = Date()

            coreDataManager.saveContext()

            completion(.creationSuccessful)
        }

        completion(.fail)
    }
}
