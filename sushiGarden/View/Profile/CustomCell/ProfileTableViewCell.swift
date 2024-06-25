//
//  ProfileTableViewCell.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {

    static let identifier = "ProfileTableViewCell"

    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold14
        label.textColor = AppConstants.Colors.white
        label.numberOfLines = 1
        return label
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
        selectionStyle = .none

        let image = UIImage(named: "appChevron")
        let chevronImage = UIImageView(image: image)
        accessoryView = chevronImage

        let contentStack = UIStackView(arrangedSubviews: [profileImage, nameLabel])
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 10

        addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }

    func configure(item: ProfileTableModel) {
        let itemImage = UIImage(named: item.imageName) ?? UIImage()
        profileImage.image = itemImage
        nameLabel.text = item.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

