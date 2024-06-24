//
//  AddressBillLabel.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class AddressBillLabel: UILabel {

    private lazy var addressBillLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.regular16
        label.textColor = AppConstants.Colors.extrasGray
        return label
    }()

    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.regular16
        label.textColor = AppConstants.Colors.extrasGray
        label.textAlignment = .right
        return label
    }()

    init(title: String, sum: Int, titleColor: UIColor = AppConstants.Colors.extrasGray, font: UIFont? = AppConstants.Fonts.regular16) {
        super.init(frame: .zero)
        setupLabel(title, sum: sum)
        setupColor(titleColor: titleColor, font: font)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel(_ title: String, sum: Int) {
        let stack = UIStackView(arrangedSubviews: [addressBillLabel, sumLabel])
        stack.axis = .horizontal

        addressBillLabel.text = title
        sumLabel.text = "\(sum)"+" $"

        addSubViews([stack])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupColor(titleColor: UIColor, font: UIFont?) {
        addressBillLabel.font = font
        addressBillLabel.textColor = titleColor
        sumLabel.font = font
        sumLabel.textColor = titleColor
    }
}
