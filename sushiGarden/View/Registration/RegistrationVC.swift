//
//  RegistrationVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit
import FirebaseAuth

final class RegistrationVC: BaseViewController {

    // MARK: - UI Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = AppConstants.Fonts.bold34
        label.textColor = AppConstants.Colors.white
        return label
    }()
    private lazy var registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.Colors.white
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    } ()
    private lazy var nameStack = RegistrationStackView(name: "Имя", placeholder: "Александр")
    private lazy var emailStack = RegistrationStackView(name: "Почта", placeholder: "example@gmail.com")
    private lazy var passwordStack = RegistrationStackView(name: "Пароль", placeholder: "**********")
    private lazy var agreementStack = AgreementStack()
    private lazy var enterButton: AppRedButton = {
        let button = AppRedButton(title: "Зарегистрироваться", height: CGFloat(71))
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var isHaveAccount: CustomButtonStack = {
        let view = CustomButtonStack(haveAccount: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(haveAccountButtonTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()

    // MARK: - UI Properties
    var coordinator: Coordinator?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IB Action
    @objc private func enterButtonTapped(_ sender: UIButton) {
        if isAllFieldsFilled() {
            let email = emailStack.textFieldText
            let password = passwordStack.textFieldText
            registration(withEmail: email, password: password)
        }
    }

    @objc private func haveAccountButtonTapped(_ sender: UITapGestureRecognizer) {
        coordinator?.goToScreen(.logIn)
    }

    // MARK: - Private methods
    private func registration(withEmail: String, password: String) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { [weak self] (authResult, error) in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let user = authResult?.user else { print("Jopa"); return }
                print("Пользователь \(withEmail) успешно зарегистрирован. Его ID: \(user.uid)")
                coordinator?.changeRootVCToTabBar()
            }
        }
    }

    private func isAllFieldsFilled() -> Bool {
        return !nameStack.textFieldText.isEmpty &&
               !emailStack.textFieldText.isEmpty &&
               !passwordStack.textFieldText.isEmpty &&
               agreementStack.isSelected
    }

    private func setupUI() {
        let buttonsStack = UIStackView(arrangedSubviews: [enterButton, isHaveAccount])
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 0

//        isHaveAccount.layer.borderWidth = 1
//        isHaveAccount.layer.borderColor = UIColor.black.cgColor

        let contentStack = UIStackView(arrangedSubviews: [nameStack, emailStack, passwordStack, agreementStack, buttonsStack])
        contentStack.axis = .vertical
        contentStack.spacing = 30

        registrationView.addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: registrationView.topAnchor, constant: 50),
            contentStack.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor, constant: 28),
            contentStack.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: registrationView.bottomAnchor, constant: -30),

//            isHaveAccount.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20),



        ])

        view.addSubViews([titleLabel, registrationView])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 202),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registrationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
