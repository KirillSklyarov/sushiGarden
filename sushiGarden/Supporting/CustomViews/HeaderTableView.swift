//
//  HeaderTableView.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 23.06.2024.
//

import UIKit

final class HeaderTableView: UIView {

    static let identifier = "HeaderCollectionReusableView"

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppConstants.Colors.white
        label.font = AppConstants.Fonts.bold16
        return label
    }()

    init(headerTitle: String) {
        super.init(frame: .zero)
        setupHeader()
        headerLabel.text = headerTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupHeader() {
        addSubViews([headerLabel])
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28)
        ])

    }

    func configureHeader(sectionName: String) {
        headerLabel.text = sectionName
    }
}
