//
//  ExpenseListViewController.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit

class ExpenseListViewController: UIViewController {

    var viewModel: ExpenseListViewModelType?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        configureTableView()
    }

    private func setupStyle() {
        self.view.backgroundColor = .white
    }

    private func configureTableView() {
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension

        self.tableView.register(UINib(nibName: "CollectiveDataCell", bundle: nil), forCellReuseIdentifier: "CollectiveDataCell")
        self.tableView.register(UINib(nibName: "ExpenseHeaderCell", bundle: nil), forCellReuseIdentifier: "ExpenseHeaderCell")
        self.tableView.register(UINib(nibName: "ExpenseItemCell", bundle: nil), forCellReuseIdentifier: "ExpenseItemCell")
    }
}
