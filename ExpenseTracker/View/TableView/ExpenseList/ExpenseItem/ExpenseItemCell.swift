//
//  ExpenseItemCell.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit

class ExpenseItemCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var bottomSeparatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupStyle(isLast: Bool) {
        backgroundColor = .lightGray
        containerView.backgroundColor = .lightGray

        nameLabel.font = UIFont(name: "System", size: 16.0)
        nameLabel.textColor = .darkText
        dateLabel.font = UIFont(name: "System", size: 16.0)
        dateLabel.textColor = .darkText
        amountLabel.font = UIFont(name: "System", size: 16.0)
        amountLabel.textColor = .darkText

        bottomSeparatorView.backgroundColor = .darkGray
        bottomSeparatorView.isHidden = isLast

        layoutIfNeeded()
    }
}
