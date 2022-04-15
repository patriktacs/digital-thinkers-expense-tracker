//
//  CollectiveDataCell.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit

class CollectiveDataCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var currencySwitch: UISwitch!
    @IBOutlet weak var currencyText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupStyle() {
        backgroundColor = .lightGray
        containerView.backgroundColor = .lightGray

        totalLabel.font = UIFont(name: "System", size: 20.0)
        totalLabel.textColor = .darkText
        totalAmountLabel.font = UIFont(name: "System", size: 16.0)
        totalAmountLabel.textColor = .systemRed
        currencyText.font = UIFont(name: "System", size: 16.0)
        currencyText.textColor = .darkText

        layoutIfNeeded()
    }
}
