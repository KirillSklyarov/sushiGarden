//
//  nameAndWeightStack.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 21.06.2024.
//

import UIKit

enum Labels {
    case weight
    case price
}

class NameAndWeightStack: UIStackView {

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

    private lazy var sushiPriceLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.tabBarGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    init(name: String, weight: Int, price: Int, nameFontSize: AppConstants.AppFonts, secondaryLabel: Labels) {
        super.init(frame: .zero)
        sushiNameLabel.text = name
        sushiWeightLabel.text = "\(weight)"+" г."
        sushiPriceLabel.text = "\(price)"+" $"

        sushiNameLabel.font = nameFontSize.font
        setupStackView(secondaryLabel: secondaryLabel)
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupStackView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    func setupStackView(secondaryLabel: Labels = .weight) {
        addArrangedSubview(sushiNameLabel)
        
        switch secondaryLabel {
            case .price: addArrangedSubview(sushiPriceLabel)
            case .weight: addArrangedSubview(sushiWeightLabel)
        }
        
        axis = .vertical
//        spacing = 8
    }
}

