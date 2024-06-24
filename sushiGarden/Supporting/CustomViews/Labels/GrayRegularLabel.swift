//
//  GrayRegularLabel.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class GrayRegularLabel: UILabel {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.regular14
        label.textColor = AppConstants.Colors.gray
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
        titleLabel.text = title
        addSubViews([titleLabel])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}