//
//  ServiceAssembly.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(ExpenseActionServiceType.self, initializer: ExpenseActionService.init).inObjectScope(.container)
    }
}
