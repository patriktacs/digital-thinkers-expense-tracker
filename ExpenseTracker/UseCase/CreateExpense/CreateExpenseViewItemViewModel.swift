//
//  CreateExpenseViewItemViewModel.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation

struct CreateExpenseViewItemViewModel {
    var nameText: String
    var namePlaceHolder: String
    var amountText: String
    var amountPlaceHolder: String
    var buttonText: String

    init() {
        nameText = "Name"
        namePlaceHolder = "Name"
        amountText = "Amount"
        amountPlaceHolder = "Amount in HUF"
        buttonText = "Save"
    }
}
