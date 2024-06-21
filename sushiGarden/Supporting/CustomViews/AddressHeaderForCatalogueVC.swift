//
//  adressHeaderForCatalogueVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 21.06.2024.
//

import UIKit

final class addressHeaderForCatalogueVC: UIView {

    private lazy var deliveryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "delivery")
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Доставка по адресу"
        label.font = AppConstants.Fonts.regular12
        label.textColor = AppConstants.Colors.catalogueGray
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Воронеж, Мира, 36"
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.titleWhite
        return label
    }()

    private lazy var chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevron")
        return imageView
    }()

    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setAddressHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddressHeader() {
        addSubViews([deliveryImage, titleStack, chevronImage])

        NSLayoutConstraint.activate([
            deliveryImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            deliveryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            deliveryImage.heightAnchor.constraint(equalToConstant: 31),
            deliveryImage.widthAnchor.constraint(equalToConstant: 31),

            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleStack.leadingAnchor.constraint(equalTo: deliveryImage.trailingAnchor, constant: 17),

            chevronImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11)
        ])
    }
}
