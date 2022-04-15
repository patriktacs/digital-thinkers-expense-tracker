//
//  ManagerAssembly.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(CoreDataManagerType.self, initializer: CoreDataManager.init).inObjectScope(.container)
    }
}
