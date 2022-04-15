//
//  ExpenseListViewModel.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import RxCocoa
import CoreData

protocol ExpenseListViewModelType {
    var isEuroRelay: BehaviorRelay<Bool> { get }
    var sectionViewModel: Driver<[ExpenseListSectionViewModel]> { get }

    func updateCurrency(isEuro: Bool)
    func setExpenseIdForUpdate(id: NSManagedObjectID)
}

public class ExpenseListViewModel: ExpenseListViewModelType {

    // Public variables

    var isEuroRelay = BehaviorRelay<Bool>(value: false)
    var sectionViewModel: Driver<[ExpenseListSectionViewModel]>

    // Dependencies

    private var coreDataManager: CoreDataManagerType
    private var expenseActionService: ExpenseActionServiceType

    // Init

    init(coreDataManager: CoreDataManagerType,
         expenseActionService: ExpenseActionServiceType) {
        self.coreDataManager = coreDataManager
        self.expenseActionService = expenseActionService

        sectionViewModel = isEuroRelay
            .map { isEuro in
                var sectionViewModels: [ExpenseListSectionViewModel] = []

                let expenses = coreDataManager.getItems(model: Expense.self)
                let expenseDates: [String] = expenses.map {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy MM"

                    if let date = $0.created {
                        return dateFormatter.string(from: date)
                    }

                    return ""
                }

                let sections: [String] = Set(expenseDates).sorted { $0 > $1 }

                let sumOfAmounts = expenses.map({ $0.amount }).reduce(0, +)
                let collectiveDataItemViewModel = ExpenseListSectionItemViewModel.collectiveDataItem(item: CollectiveDataCellItemViewModel(totalAmount: sumOfAmounts, isEuro: isEuro, exchangeRate: 400.0))

                sectionViewModels.append(ExpenseListSectionViewModel.collectiveDataSection(items: [collectiveDataItemViewModel]))

                if !sections.isEmpty {
                    for section in sections {
                        var itemViewModels: [ExpenseListSectionItemViewModel] = []
                        for expense in expenses {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy MM"

                            if let date = expense.created,
                               dateFormatter.string(from: date) == section {
                                itemViewModels.append(ExpenseListSectionItemViewModel.expenseItem(item: ExpenseItemCellItemViewModel(expense: expense, isEuro: isEuro, exchangeRate: 400.0)))
                            }
                        }

                        sectionViewModels.append(ExpenseListSectionViewModel.expensesSection(title: section, items: itemViewModels))
                    }
                }

                return sectionViewModels
            }
            .asDriver(onErrorJustReturn: [])
    }

    // Public methods

    public func updateCurrency(isEuro: Bool) {
        if !(isEuro == self.isEuroRelay.value) {
            self.isEuroRelay.accept(isEuro)
        }
    }

    public func setExpenseIdForUpdate(id: NSManagedObjectID) {
        expenseActionService.editedExpenseId.accept(id)
    }
}
