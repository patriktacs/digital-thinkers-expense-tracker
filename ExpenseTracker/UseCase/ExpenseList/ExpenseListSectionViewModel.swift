//
//  ExpenseListSectionViewModel.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import RxDataSources

enum ExpenseListSectionViewModel {
    case collectiveDataSection(items: [ExpenseListSectionItemViewModel])
    case expensesSection(title: String, items: [ExpenseListSectionItemViewModel])
}

enum ExpenseListSectionItemViewModel {
    case collectiveDataItem(item: CollectiveDataCellItemViewModel)
    case expenseItem(item: ExpenseItemCellItemViewModel)
}

extension ExpenseListSectionViewModel: SectionModelType {

    init(original: ExpenseListSectionViewModel, items: [ExpenseListSectionItemViewModel]) {
        switch original {
        case .collectiveDataSection(let items):
            self = .collectiveDataSection(items: items)
        case .expensesSection(let title, let items):
            self = .expensesSection(title: title, items: items)
        }
    }

    var items: [ExpenseListSectionItemViewModel] {
        switch self {
        case .collectiveDataSection(let items):
            return items
        case .expensesSection(_, let items):
            return items
        }
    }
}

