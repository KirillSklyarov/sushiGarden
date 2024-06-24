//
//  CartTableViewCell.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 22.06.2024.
//

import UIKit

final class CartTableViewCell: UITableViewCell {

    static let identifier = "CartTableViewCell"

    private lazy var orderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 105).isActive = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.titleWhite
        label.numberOfLines = 1
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.titleWhite
        return label
    }()

    private lazy var stepper: CustomStepper = {
        let stepper = CustomStepper(width: 84)
        return stepper
    }()

    private lazy var cartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appCartImage")
        imageView.contentMode = .right
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        backgroundColor = .clear

        let namePriceStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel, stepper])
        namePriceStack.axis = .vertical
        namePriceStack.alignment = .leading
        namePriceStack.spacing = 5

//        namePriceStack.layer.borderColor = UIColor.red.cgColor
//        namePriceStack.layer.borderWidth = 1
//
//        cartImage.layer.borderWidth = 1
//        cartImage.layer.borderColor = UIColor.red.cgColor

        let contentStack = UIStackView(arrangedSubviews: [orderImage, namePriceStack, cartImage])
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 10
        contentStack.distribution = .equalSpacing

//        contentStack.layer.borderWidth = 1
//        contentStack.layer.borderColor = UIColor.red.cgColor

        addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -46),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),

            namePriceStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
        ])
    }

    func configure(image: String, name: String, price: Int) {
        let itemImage = UIImage(named: image) ?? UIImage()
        let priceTitle = "\(price)"+" $"

        orderImage.image = itemImage
        nameLabel.text = name
        priceLabel.text = priceTitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
