//
//  ExpenseListViewController.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit
import RxDataSources

class ExpenseListViewController: UIViewController {

    var viewModel: ExpenseListViewModelType?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createNewButton: UIButton!

    private var dataSource: RxTableViewSectionedReloadDataSource<ExpenseListSectionViewModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureDataSource()
        setupData()
        setupStyle()

        createNewButton.addTarget(self, action: #selector(navAction), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = "Home"

        if let viewModel = viewModel {
            viewModel.isEuroRelay.accept(viewModel.isEuroRelay.value)
        }
    }

    @objc func navAction(sender: UIButton!) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CreateExpenseViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func navToUpdate() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CreateExpenseViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func setupData() {
        guard let dataSource = dataSource,
              let viewModel = viewModel else { return }

        viewModel.sectionViewModel
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }

    private func setupStyle() {
        view.backgroundColor = .white
    }

    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension

        tableView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)

        tableView.register(UINib(nibName: "CollectiveDataCell", bundle: nil), forCellReuseIdentifier: "CollectiveDataCell")
        tableView.register(UINib(nibName: "ExpenseHeaderCell", bundle: nil), forCellReuseIdentifier: "ExpenseHeaderCell")
        tableView.register(UINib(nibName: "ExpenseItemCell", bundle: nil), forCellReuseIdentifier: "ExpenseItemCell")

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self,
                  let dataSource = self.dataSource else { return }

            switch dataSource[indexPath.section] {
            case .expensesSection(_, let items):
                guard let viewModel = self.viewModel else { return }

                if case let .expenseItem(item) = items[indexPath.row] {
                    viewModel.setExpenseIdForUpdate(id: item.id)
                    DispatchQueue.main.async {
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CreateExpenseViewController")
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            default:
                break
            }

        }).disposed(by: rx.disposeBag)
    }

    private func configureDataSource() {
        guard let viewModel = viewModel else { return }

        dataSource = RxTableViewSectionedReloadDataSource<ExpenseListSectionViewModel>(configureCell: { (_, table, idxPath, model) in
            switch model {
            case .expenseItem(let item):
                guard let cell: ExpenseItemCell = table.dequeueReusableCell(withIdentifier: "ExpenseItemCell", for: idxPath) as? ExpenseItemCell else { return UITableViewCell() }
                cell.setupData(data: item)

                return cell
            case .collectiveDataItem(let item):
                guard let cell: CollectiveDataCell = table.dequeueReusableCell(withIdentifier: "CollectiveDataCell", for: idxPath) as? CollectiveDataCell else { return UITableViewCell() }
                cell.setupData(data: item)
                cell.currencyAction = viewModel.updateCurrency

                return cell
            }
        })
    }
}

extension ExpenseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = dataSource else { return nil }

        switch dataSource[section] {
        case .expensesSection(let title, _):
            guard let cell: ExpenseHeaderCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseHeaderCell") as? ExpenseHeaderCell else { return UITableViewCell() }
                cell.setupData(title: title)

                return cell
        default:
            let view = UIView()
            view.backgroundColor = .clear

            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let dataSource = dataSource else { return 0.0 }

        switch dataSource[section] {
        case .expensesSection:
            return 40.0
        default:
            return 0.0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}
