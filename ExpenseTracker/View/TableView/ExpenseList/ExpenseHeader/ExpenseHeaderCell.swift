//
//  ExpenseHeaderCell.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit

class ExpenseHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupStyle() {
        backgroundColor = .lightGray

        titleLabel.font = UIFont(name: "System", size: 24.0)
        titleLabel.textColor = .darkText

        layoutIfNeeded()
    }
}
