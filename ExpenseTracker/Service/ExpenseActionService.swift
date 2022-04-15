//
//  ExpenseActionService.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import RxCocoa

protocol ExpenseActionServiceType {
    var editedExpenseId: BehaviorRelay<String?> { get }
}

class ExpenseActionService: ExpenseActionServiceType {
    var editedExpenseId = BehaviorRelay<String?>(value: nil)
}
