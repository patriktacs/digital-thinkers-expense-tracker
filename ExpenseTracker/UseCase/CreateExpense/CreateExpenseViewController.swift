//
//  CreateExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit
import RxCocoa
import RxBiBinding

class CreateExpenseViewController: UIViewController, UIPickerViewDelegate {

    var viewModel: CreateExpenseViewModelType?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var saveButton: UIButton!

    private var categoryOptions = BehaviorRelay<[String]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else { return }

        setupStyle()

        viewModel.itemViewModel
            .subscribe(onNext: { [weak self] itemViewModel in
                guard let self = self else { return }

                self.setupData(data: itemViewModel)
            }).disposed(by: rx.disposeBag)

        viewModel.categoryOptions
            .bind(to: categoryOptions)
            .disposed(by: rx.disposeBag)

        viewModel.categoryOptions
            .bind(to: categoryPickerView.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: rx.disposeBag)

        (nameTextField.rx.text <-> viewModel.nameValue).disposed(by: rx.disposeBag)
        (amountTextField.rx.text <-> viewModel.amountValue).disposed(by: rx.disposeBag)
        categoryPickerView.rx.itemSelected.subscribe(onNext: { [weak self] item in
            guard let self = self else { return }
            
            viewModel.categoryValue.accept(self.categoryOptions.value[item.row])
        }).disposed(by: rx.disposeBag)

        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = "Create expense"
    }

    @objc func saveAction(sender: UIButton!) {
        guard let viewModel = viewModel else { return }

        viewModel.saveExpense(completion: { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .updateSuccessful, .creationSuccessful:
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .fail:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Ar error occured while we tried to handle your request. Please try again!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }

    private func setupData(data: CreateExpenseViewItemViewModel) {
        nameLabel.text = data.nameText
        nameTextField.placeholder = data.namePlaceHolder
        amountLabel.text = data.amountText
        amountTextField.placeholder = data.amountPlaceHolder
        saveButton.setTitle(data.buttonText, for: .normal)

        amountTextField.delegate = self
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

extension CreateExpenseViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil || string.isEmpty {
            return true
        } else {
            return false
        }
    }
}
