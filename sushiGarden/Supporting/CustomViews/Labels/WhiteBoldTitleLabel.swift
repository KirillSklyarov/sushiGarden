//
//  AddressLabel.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class WhiteBoldTitleLabel: UILabel {

    private lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.white
        return label
    }()

    init(title: String) {
        super.init(frame: .zero)
        setupLabel(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel(_ title: String) {
        addressTitleLabel.text = title
        addSubViews([addressTitleLabel])

        NSLayoutConstraint.activate([
            addressTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            addressTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            addressTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
