//
//  CatNamesCollectionViewCell.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 21.06.2024.
//

import UIKit

final class CatNamesCollectionViewCell: UICollectionViewCell {

    static let identifier = "CatNamesCollectionViewCell"

    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.tabBarGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        contentView.addSubViews([categoryName])

        NSLayoutConstraint.activate([
            categoryName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    func configure(name: String) {
        categoryName.text = name
    }
}

