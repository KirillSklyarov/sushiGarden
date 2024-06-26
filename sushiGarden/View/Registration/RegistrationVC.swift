//
//  RegistrationVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit
import Firebase

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

    // MARK: - Other Properties
    private let fireStore = Firestore.firestore()
    var coordinator: Coordinator?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IB Action
    @objc private func enterButtonTapped(_ sender: UIButton) {
        if isAllFieldsFilled() {
            registerUserAndSaveData()
        } else {
            let emptyFields = emptyFields()
            self.showAlert(emptyFields: emptyFields)
        }
    }

    @objc private func haveAccountButtonTapped(_ sender: UITapGestureRecognizer) {
        coordinator?.goToScreen(.logIn)
    }

    private func emptyFields() -> String {
        var array = [String]()
        let stacks = [nameStack, emailStack, passwordStack]
        stacks.forEach {
            if $0.textFieldText.isEmpty {
                array.append($0.headerLabel.text ?? "")
            }
        }
        if agreementStack.isSelected == false {
            array.append("Политика и условия")
        }

        let arrayToString = array.joined(separator: ", ")

        return arrayToString
    }

    // MARK: - Private methods
    private func registerUserAndSaveData() {
        let currentUser = User(name: nameStack.textFieldText,
                               email: emailStack.textFieldText,
                               password: passwordStack.textFieldText)
        registration(currentUser)
    }

    private func registration(_ user: User) {
        ProgressIndicator.show()
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] (authResult, error) in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
                showErrorAlert(error: error.localizedDescription)
            } else {
                ProgressIndicator.succeed()
                guard let userData = authResult?.user else { print("Jopa"); return }
                print("Пользователь \(user.email) успешно зарегистрирован. Его ID: \(userData.uid)")
                saveUserToFirebase(user)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.coordinator?.changeRootVCToTabBar()
                }
            }
        }
    }

    private func saveUserToFirebase(_ user: User) {
        fireStore.collection(AppConstants.Firestore.Collections.user).addDocument(
            data: [AppConstants.Firestore.UserData.name : user.name,
                   AppConstants.Firestore.UserData.email : user.email
                  ]) { [weak self] error in
                      guard self != nil else { return }
                      if let error {
                          print(error.localizedDescription)
                      } else {
                          print("User saved successfully")
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

        let contentStack = UIStackView(arrangedSubviews: [nameStack, emailStack, passwordStack, agreementStack, buttonsStack])
        contentStack.axis = .vertical
        contentStack.spacing = 30

        registrationView.addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: registrationView.topAnchor, constant: 50),
            contentStack.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor, constant: 28),
            contentStack.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: registrationView.bottomAnchor, constant: -30)
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
