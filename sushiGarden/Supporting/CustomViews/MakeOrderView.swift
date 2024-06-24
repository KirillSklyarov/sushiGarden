//
//  appEnterButton.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 23.06.2024.
//

import UIKit

final class MakeOrderView: UIView {

    private lazy var makeOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Оформить заказ"
        label.font = AppConstants.Fonts.bold18
        label.textColor = AppConstants.Colors.white
        return label
    }()

    private lazy var totalSumLabel: UILabel = {
        let label = UILabel()
        label.text = "1680 $"
        label.font = AppConstants.Fonts.bold18
        label.textColor = AppConstants.Colors.white
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupButtonStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupButtonStackView() {
        backgroundColor = AppConstants.Colors.red
        layer.cornerRadius = 17
        clipsToBounds = true

        let contentStack = UIStackView(arrangedSubviews: [makeOrderLabel, totalSumLabel])
        contentStack.axis = .horizontal

        addSubViews([contentStack])
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
        ])
    }
}

