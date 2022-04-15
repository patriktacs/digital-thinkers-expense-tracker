//
//  CreateExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit

class CreateExpenseViewController: UIViewController {

    var viewModel: CreateExpenseViewModelType?


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = "Create expense"
    }

    private func setupStyle() {
        view.backgroundColor = .white
        categoryPickerView.backgroundColor = .white
        containerView.backgroundColor = .white

        nameLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        nameLabel.textColor = .darkText
        amountLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        amountLabel.textColor = .darkText

        saveButton.backgroundColor = .systemOrange
        saveButton.tintColor = .white
    }
}
