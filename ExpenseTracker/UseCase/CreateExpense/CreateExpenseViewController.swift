//
//  CreateExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit

class CreateExpenseViewController: UIViewController {

    var viewModel: CreateExpenseViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.title = "Create expense"
    }
}
