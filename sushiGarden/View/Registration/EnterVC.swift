//
//  RegistrationVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

final class EnterVC: BaseViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
        label.font = AppConstants.Fonts.bold34
        label.textColor = AppConstants.Colors.titleWhite
        return label
    }()

    private lazy var registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.Colors.titleWhite
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let emailStack = RegistrationStackView(name: "Почта", placeholder: "example@gmail.com")
        let passwordStack = RegistrationStackView(name: "Пароль", placeholder: "**********")

        let textFieldsStack = UIStackView(arrangedSubviews: [emailStack, passwordStack])
        textFieldsStack.axis = .vertical
        textFieldsStack.spacing = 28

        let buttonStack = CustomButtonStack(haveAccount: true)

        let contentStack = UIStackView(arrangedSubviews: [textFieldsStack, buttonStack])
        contentStack.axis = .vertical
        contentStack.spacing = 84

        registrationView.addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: registrationView.topAnchor, constant: 50),
            contentStack.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor, constant: 28),
            contentStack.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor, constant: -28),
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
            return EnterVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = EnterVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderEnter.ContainterView>) -> EnterVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderEnter.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderEnter.ContainterView>) {

        }
    }
}
