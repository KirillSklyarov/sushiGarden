//
//  CustomButtonStack.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

final class CustomButtonStack: UIStackView {

    private lazy var haveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.regular18
        label.textColor = AppConstants.Colors.textDarkGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = AppConstants.Fonts.bold16
        button.setTitleColor(AppConstants.Colors.buttonRed, for: .normal)
        return button
    }()

    init(haveAccount: Bool) {
        super.init(frame: .zero)
        setupButtonStackView(haveAccount)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var enterButton = setupEnterButton()

    func setup() -> UIView {
        let haveAccountStack = UIStackView(arrangedSubviews: [haveAccountLabel, accountButton])
        haveAccountStack.axis = .horizontal
        haveAccountStack.spacing = 3
        let accountContainer = UIView()
        accountContainer.addSubViews([haveAccountStack])

        NSLayoutConstraint.activate([
            haveAccountStack.centerXAnchor.constraint(equalTo: accountContainer.centerXAnchor),
            haveAccountStack.centerYAnchor.constraint(equalTo: accountContainer.centerYAnchor),
        ])
        return accountContainer
    }

    func setupButtonStackView(_ haveAccount: Bool) {
        if haveAccount {
            haveAccountLabel.text = "Уже есть аккаунт?"
            accountButton.setTitle("Войти".uppercased(), for: .normal)
        } else {
            haveAccountLabel.text = "У вас нет аккаунта?"
            accountButton.setTitle("Регистрация".uppercased(), for: .normal)
        }

        let accountContainer = setup()
        addArrangedSubview(enterButton)
        addArrangedSubview(accountContainer)
        axis = .vertical
        spacing = 28
    }
}
