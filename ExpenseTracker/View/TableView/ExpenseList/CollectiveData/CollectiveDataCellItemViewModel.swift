//
//  CollectiveDataCellItemViewModel.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation

struct CollectiveDataCellItemViewModel {
    var totalText: String
    var totalAmountText: String
    var currencyText: String
    var isEuro: Bool

    init(totalAmount: Double, isEuro: Bool, exchangeRate: Double) {
        totalText = "Total"
        totalAmountText = isEuro ? "\(String(totalAmount / exchangeRate)) EUR" : "\(totalAmount) HUF"
        currencyText = "Show EUR"
        self.isEuro = isEuro
    }

    init() {
        totalText = ""
        totalAmountText = ""
        currencyText = ""
        isEuro = false
    }
}
