//
//  DetailCollectionViewCell.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 21.06.2024.
//

import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {

    static let identifier = "DetailCollectionViewCell"

    private lazy var sushiImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    private lazy var sushiNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.titleWhite
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var sushiWeightLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.tabBarGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("₽", for: .normal)
        button.titleLabel?.font = AppConstants.Fonts.bold19
        button.backgroundColor = AppConstants.Colors.detailDarkGray
        button.titleLabel?.textColor = AppConstants.Colors.titleWhite
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = AppConstants.Colors.titleWhite.cgColor
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 0.7

        let nameStack = UIStackView(arrangedSubviews: [sushiNameLabel, sushiWeightLabel])
        nameStack.axis = .vertical

        contentView.addSubViews([sushiImage, nameStack, priceButton])

        NSLayoutConstraint.activate([
//            sushiImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            sushiImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            sushiImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            sushiImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            sushiImage.widthAnchor.constraint(equalToConstant: 185),
            sushiImage.heightAnchor.constraint(equalToConstant: 185),

            nameStack.topAnchor.constraint(equalTo: sushiImage.bottomAnchor, constant: 8),
            nameStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            priceButton.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 18),
            priceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            priceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
//            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(image: String, name: String, weight: Int, price: Int) {
        let itemImage = UIImage(named: image) ?? UIImage()
        let priceTitle = "\(price)"+" $"
        let weightTitle = "\(weight)"+" г."

        sushiImage.image = itemImage
        sushiNameLabel.text = name
        sushiWeightLabel.text = weightTitle
        priceButton.setTitle(priceTitle, for: .normal)

    }
}
