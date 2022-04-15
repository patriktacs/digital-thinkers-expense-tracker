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

    public func setupData(data: ExpenseItemCellItemViewModel) {
        nameLabel.text = data.nameText
        categoryImage.image = UIImage(systemName: data.categoryImageName)
        dateLabel.text = data.dateText
        amountLabel.text = data.amountText

        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .white
        containerView.backgroundColor = .white
        selectionStyle = .none

        nameLabel.font = nameLabel.font.withSize(16)
        nameLabel.textColor = .darkText
        dateLabel.font = dateLabel.font.withSize(16)
        dateLabel.textColor = .darkText
        amountLabel.font = amountLabel.font.withSize(16)
        amountLabel.textColor = .darkText
        amountLabel.textAlignment = .right

        bottomSeparatorView.backgroundColor = .darkGray

        layoutIfNeeded()
    }
}
