//
//  RegistrationVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

final class RegistrationVC: BaseViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = Constants.AppFonts.bold34
        label.textColor = Constants.AppColors.titleWhite
        return label
    }()

    private lazy var registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.AppColors.titleWhite
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    } ()

    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Я согласен с Условиями предоставления услуг и Политикой конфиденциальности"
        label.font = Constants.AppFonts.regular14
        label.textColor = Constants.AppColors.agreementGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var agreementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "agreementCheckBox"), for: .normal)
        return button
    }()

    private lazy var haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = Constants.AppFonts.regular18
        label.textColor = Constants.AppColors.textDarkGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти".uppercased(), for: .normal)
        button.titleLabel?.font = Constants.AppFonts.bold16
        button.setTitleColor(Constants.AppColors.buttonRed, for: .normal)
        return button
    }()

    private lazy var enterButton = setupEnterButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let nameStack = RegistrationStackView(name: "Имя", placeholder: "Александр")
        let emailStack = RegistrationStackView(name: "Почта", placeholder: "example@gmail.com")
        let passwordStack = RegistrationStackView(name: "Пароль", placeholder: "**********")

        let buttonStack = UIStackView(arrangedSubviews: [agreementButton, agreementLabel])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 23

        let haveAccountStack = UIStackView(arrangedSubviews: [haveAccountLabel, accountButton])
        haveAccountStack.axis = .horizontal
        haveAccountStack.spacing = 3
        let accountContainer = UIView()
        accountContainer.addSubViews([haveAccountStack])


        NSLayoutConstraint.activate([
            haveAccountStack.centerXAnchor.constraint(equalTo: accountContainer.centerXAnchor),
            haveAccountStack.centerYAnchor.constraint(equalTo: accountContainer.centerYAnchor),
        ])

        let contentStack = UIStackView(arrangedSubviews: [nameStack, emailStack, passwordStack, buttonStack, enterButton, accountContainer])
        contentStack.axis = .vertical
        contentStack.spacing = 28

        view.addSubViews([titleLabel, registrationView, contentStack])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 202),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registrationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: registrationView.topAnchor, constant: 50),
            contentStack.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor, constant: 28),
            contentStack.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor, constant: -28),

            enterButton.heightAnchor.constraint(equalTo: registrationView.heightAnchor, multiplier: 71 / 664),
            accountContainer.heightAnchor.constraint(equalTo: registrationView.heightAnchor, multiplier: 28/664),
            accountContainer.bottomAnchor.constraint(equalTo: registrationView.bottomAnchor, constant: -50)

        ])
    }
}
