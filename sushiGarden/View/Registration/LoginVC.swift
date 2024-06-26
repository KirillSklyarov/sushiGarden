//
//  RegistrationVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class LoginVC: BaseViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
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
    let emailStack = RegistrationStackView(name: "Почта", placeholder: "example@gmail.com")
    let passwordStack = RegistrationStackView(name: "Пароль", placeholder: "**********")
    private lazy var enterButton: AppRedButton = {
        let button = AppRedButton(title: "Войти".uppercased(), height: CGFloat(71))
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var isHaveAccount: CustomButtonStack = {
        let view = CustomButtonStack(haveAccount: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(haveAccountButtonTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()

    // MARK: - UI Properties
    var coordinator: Coordinator?

    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @objc private func haveAccountButtonTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }

    @objc private func enterButtonTapped(_ sender: UIButton) {
        if isAllFieldsFilled() {
            let email = emailStack.textFieldText
            let password = passwordStack.textFieldText
            loginUser(withEmail: email, password: password)
        } else {
            let emptyFields = emptyFields()
            self.showAlert(emptyFields: emptyFields)
        }
    }


    private func emptyFields() -> String {
        var array = [String]()
        let stacks = [emailStack, passwordStack]
        stacks.forEach {
            if $0.textFieldText.isEmpty {
                array.append($0.headerLabel.text ?? "")
            }
        }
        let arrayToString = array.joined(separator: ", ")

        return arrayToString
    }

    private func isAllFieldsFilled() -> Bool {
        return !emailStack.textFieldText.isEmpty &&
               !passwordStack.textFieldText.isEmpty
    }

    private func loginUser(withEmail: String, password: String) {
        ProgressIndicator.show()
        Auth.auth().signIn(withEmail: withEmail, password: password) { [weak self] AuthDataResult, error in
            guard let self else { print("Aauuch"); return }
            if let error {
                print("Failed to login user: \(error.localizedDescription)")
            } else {
                ProgressIndicator.succeed()
                print("User logged in successfully")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.coordinator?.changeRootVCToTabBar()
                }
            }
        }
    }

    private func setupUI() {
        let textFieldsStack = UIStackView(arrangedSubviews: [emailStack, passwordStack])
        textFieldsStack.axis = .vertical
        textFieldsStack.spacing = 28

        let buttonsStack = UIStackView(arrangedSubviews: [enterButton, isHaveAccount])
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 20

        let contentStack = UIStackView(arrangedSubviews: [textFieldsStack, buttonsStack])
        contentStack.axis = .vertical
        contentStack.spacing = 50

        registrationView.addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: registrationView.topAnchor, constant: 50),
            contentStack.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor, constant: 28),
            contentStack.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor, constant: -28),
            contentStack.bottomAnchor.constraint(equalTo: registrationView.bottomAnchor),

        ])

        view.addSubViews([titleLabel, registrationView])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 202),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registrationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderEnter : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return LoginVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = LoginVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderEnter.ContainterView>) -> LoginVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderEnter.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderEnter.ContainterView>) {

        }
    }
}
