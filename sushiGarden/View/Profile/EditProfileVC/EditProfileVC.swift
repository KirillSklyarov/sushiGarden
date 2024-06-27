//
//  EditProfileVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 25.06.2024.
//

import UIKit

final class EditProfileVC: BaseViewController {

    // MARK: - UI Properties
    private lazy var nameTitleLabel = WhiteBoldTitleLabel(title: "Имя")
    private lazy var changeNameTextField = AddressTextFieldView(placeholderText: "Введите новое имя")
    private lazy var cityTitleLabel = WhiteBoldTitleLabel(title: "Город")
    private lazy var changeCityTextField = AddressTextFieldView(placeholderText: "Введите новый город")

    private lazy var phoneTitleLabel = WhiteBoldTitleLabel(title: "Телефон")
    private lazy var changePhoneTextField = AddressTextFieldView(placeholderText: "Введите новый номер телефона")

    private lazy var profilePhoto: UIImageView = {
        let imageSize = view.bounds.width / 3
        let imageView = UIImageView(image: UIImage(named: "photo"))
        imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        return imageView
    }()
    private lazy var nameLabel = WhiteBoldTitleLabel(title: "John")
    private lazy var emailLabel = GrayRegularLabel(title: "john@mail.ru")

    private var currentUser = Storage.shared.currentUser

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTitleFromCurrentUser()
    }

    // MARK: - Private methods
    private func setTitleFromCurrentUser() {
        guard let currentUser else { print("1"); return }
        print(currentUser)
        changeNameTextField.updateTitle(currentUser.name)
        nameLabel.updateTitle(currentUser.name)
        emailLabel.updateTitle(currentUser.email)
    }

    private func setupUI() {
        let personalView = setupPersonalView()
        let editionView = setupEditionDataView()

        let contentStack = UIStackView(arrangedSubviews: [personalView, editionView])
        contentStack.axis = .vertical
        contentStack.distribution = .fillEqually
        contentStack.spacing = 50

        view.addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setupEditionDataView() -> UIView {
        let nameStack = UIStackView(arrangedSubviews: [nameTitleLabel, changeNameTextField])
        nameStack.axis = .vertical
        nameStack.spacing = 10

        let phoneStack = UIStackView(arrangedSubviews: [phoneTitleLabel, changePhoneTextField])
        phoneStack.axis = .vertical
        phoneStack.spacing = 10

        let cityStack = UIStackView(arrangedSubviews: [cityTitleLabel, changeCityTextField])
        cityStack.axis = .vertical
        cityStack.spacing = 10

        let editionStack = UIStackView(arrangedSubviews: [nameStack, phoneStack, cityStack])
        editionStack.axis = .vertical
        editionStack.spacing = 20

        let editionView = UIView()
        editionView.addSubViews([editionStack])

        NSLayoutConstraint.activate([
            editionStack.topAnchor.constraint(equalTo: editionView.topAnchor),
            editionStack.leadingAnchor.constraint(equalTo: editionView.leadingAnchor),
            editionStack.trailingAnchor.constraint(equalTo: editionView.trailingAnchor)
        ])

        return editionView
    }

    private func setupPersonalView() -> UIView {
        let personalStack = UIStackView(arrangedSubviews: [profilePhoto, nameLabel, emailLabel])
        personalStack.axis = .vertical
        personalStack.alignment = .center
        personalStack.spacing = 15

        let personalView = UIView()
        personalView.addSubViews([personalStack])

        NSLayoutConstraint.activate([
            personalStack.centerXAnchor.constraint(equalTo: personalView.centerXAnchor),
            personalStack.centerYAnchor.constraint(equalTo: personalView.centerYAnchor),
        ])
        return personalView
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderEditProfile : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return EditProfileVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = EditProfileVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderEditProfile.ContainterView>) -> EditProfileVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderEditProfile.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderEditProfile.ContainterView>) {

        }
    }
}
