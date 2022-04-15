//
//  ViewAssembly.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ViewAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(ExpenseListViewModelType.self, initializer: ExpenseListViewModel.init)
        container.storyboardInitCompleted(ExpenseListViewController.self, initCompleted: { r,c in
        c.viewModel = r.resolve(ExpenseListViewModel.self) })
    }
}
