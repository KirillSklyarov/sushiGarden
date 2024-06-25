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
        label.textColor = AppConstants.Colors.darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var redLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.bold19
        label.textColor = AppConstants.Colors.red
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    init(haveAccount: Bool) {
        super.init(frame: .zero)
        setupButtonStackView(haveAccount)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentStack() -> UIView {
        let haveAccountStack = UIStackView(arrangedSubviews: [haveAccountLabel, redLabel])
        haveAccountStack.axis = .vertical
        haveAccountStack.spacing = 3

        let accountContainer = UIView()
        accountContainer.addSubViews([haveAccountStack])

        NSLayoutConstraint.activate([
            haveAccountStack.topAnchor.constraint(equalTo: accountContainer.topAnchor, constant: 10),
            haveAccountStack.centerXAnchor.constraint(equalTo: accountContainer.centerXAnchor),
        ])
        return accountContainer
    }

    func setupButtonStackView(_ haveAccount: Bool) {
        if haveAccount {
            haveAccountLabel.text = "У вас нет аккаунта?"
            redLabel.text = "Регистрация"
        } else {
            haveAccountLabel.text = "Уже есть аккаунт?"
            redLabel.text = "Войти"
        }

        let accountContainer = setupContentStack()

        addArrangedSubview(accountContainer)
    }
}
