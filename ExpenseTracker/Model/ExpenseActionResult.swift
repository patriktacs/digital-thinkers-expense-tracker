//
//  ExpenseActionResult.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation

public enum ExpenseActionResult: String, Codable {
    case updateSuccessful
    case creationSuccessful
    case fail
}
