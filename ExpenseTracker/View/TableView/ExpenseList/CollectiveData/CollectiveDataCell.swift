//
//  CollectiveDataCell.swift
//  ExpenseTracker
//
//  Created by Ács, Patrik, Vodafone Hungary on 2022. 04. 15..
//

import UIKit
import RxSwift

class CollectiveDataCell: UITableViewCell {

    var currencyAction: ((Bool) -> ())?

    private var disposeBag = DisposeBag()

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var currencySwitch: UISwitch!
    @IBOutlet weak var currencyText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setupData(data: CollectiveDataCellItemViewModel) {
        self.totalLabel.text = data.totalText
        self.totalAmountLabel.text = data.totalAmountText
        self.currencyText.text = data.currencyText
        self.currencySwitch.isOn = data.isEuro

        currencySwitch.rx.isOn
            .subscribe(onNext: { isOn in
                guard let currencyAction = self.currencyAction else { return }

                currencyAction(isOn)
            }).disposed(by: disposeBag)
        self.setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .white
        containerView.backgroundColor = .white
        selectionStyle = .none

        totalLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        totalLabel.textColor = .darkText
        totalAmountLabel.font = totalAmountLabel.font.withSize(16)
        totalAmountLabel.textColor = .darkText
        currencyText.font = currencyText.font.withSize(16)
        currencyText.textColor = .darkText

        layoutIfNeeded()
    }
}
