//
//  AgreementStack.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 25.06.2024.
//

import UIKit

final class AgreementStack: UIStackView {

    var isSelected = false

    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Я согласен с Условиями предоставления услуг и Политикой конфиденциальности"
        label.font = AppConstants.Fonts.regular14
        label.textColor = AppConstants.Colors.gray
        label.numberOfLines = 0
        return label
    }()
    private lazy var agreementButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "agreementCheckBox")
        button.setImage(buttonImage, for: .normal)
        let selectedButtonImage = buttonImage?.withTintColor(AppConstants.Colors.red)
        button.setImage(selectedButtonImage, for: .selected)
        button.addTarget(self, action: #selector(agreementButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupStack()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStack() {
        addArrangedSubview(agreementButton)
        addArrangedSubview(agreementLabel)
        axis = .horizontal
        spacing = 23
    }

    @objc private func agreementButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        isSelected.toggle()
    }
}


