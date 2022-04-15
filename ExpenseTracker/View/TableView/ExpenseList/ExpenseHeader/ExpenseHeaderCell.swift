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

    public func setupData(title: String) {
        self.titleLabel.text = title

        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .white
        selectionStyle = .none

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textColor = .darkText

        layoutIfNeeded()
    }
}
