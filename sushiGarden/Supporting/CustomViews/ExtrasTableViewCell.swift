//
//  extrasTableViewCell.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 23.06.2024.
//

import UIKit

final class ExtrasTableViewCell: UITableViewCell {

    static let identifier = "ExtrasTableViewCell"

    private lazy var extraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold14
        label.textColor = AppConstants.Colors.white
        label.numberOfLines = 1
        return label
    }()

    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.regular14
        label.textColor = AppConstants.Colors.lightGray
        return label
    }()

    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("₽", for: .normal)
        button.titleLabel?.font = AppConstants.Fonts.bold19
        button.backgroundColor = AppConstants.Colors.darkGray
        button.titleLabel?.textColor = AppConstants.Colors.white
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
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

        let namePriceStack = UIStackView(arrangedSubviews: [nameLabel, weightLabel])
        namePriceStack.axis = .vertical
        namePriceStack.alignment = .leading
        namePriceStack.spacing = 5

//        extraImage.layer.borderWidth = 1
//        extraImage.layer.borderColor = UIColor.red.cgColor
//
//        namePriceStack.layer.borderWidth = 1
//        namePriceStack.layer.borderColor = UIColor.red.cgColor

        let contentStack = UIStackView(arrangedSubviews: [extraImage, namePriceStack, priceButton])
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 13

        addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            extraImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 28/430),
            priceButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 83/430),
        ])
    }

    func configure(item: extrasDetail) {
        let itemImage = UIImage(named: item.imageName) ?? UIImage()
        let priceTitle = "\(item.price)"+" $"
        let weightTitle = "\(item.weight)"+" г"

        extraImage.image = itemImage
        nameLabel.text = item.name
        weightLabel.text = weightTitle
        priceButton.setTitle(priceTitle, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
