//
//  EditProfileVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 25.06.2024.
//

import UIKit
import Firebase

final class EditProfileVC: BaseViewController {

    // MARK: - UI Properties
    private lazy var nameTitleLabel = WhiteBoldTitleLabel(title: "Имя")
    private lazy var changeNameTextField = TextFieldAndLineView(placeholderText: "Введите новое имя")
    private lazy var cityTitleLabel = WhiteBoldTitleLabel(title: "Город")
    private lazy var changeCityTextField = TextFieldAndLineView(placeholderText: "Введите новый город")

    private lazy var phoneTitleLabel = WhiteBoldTitleLabel(title: "Телефон")
    private lazy var changePhoneTextField = TextFieldAndLineView(placeholderText: "Введите новый номер телефона")

    private lazy var profilePhoto: UIImageView = {
        let imageSize = view.bounds.width / 3
        let imageView = UIImageView(image: UIImage(named: "photo"))
        imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        return imageView
    }()
    private lazy var nameLabel = WhiteBoldTitleLabel(title: "John")
    private lazy var emailLabel = GrayRegularLabel(title: "john@mail.ru")

    private lazy var saveButton: AppRedButton = {
        let button = AppRedButton(title: "Сохранить")
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Other Properties
    private let currentUser = Storage.shared.currentUser
    private let fireStore = Firestore.firestore()

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTitleFromCurrentUser()
    }

    // MARK: - IB Action
    @objc private func saveButtonTapped(sender: UIButton) {
        resignAllTextFields()

        Task {
            await saveProfileChanges()
        }
    }

    // MARK: - Private methods
    private func resignAllTextFields() {
        let textFields = [changeNameTextField, changePhoneTextField, changeCityTextField]
        textFields.forEach { $0.resign() }
    }

    private func saveProfileChanges() async {
        let name = changeNameTextField.text
        guard let userID = currentUser?.userID else { print("Error getting UserID"); return }

        do {
            try await fireStore.collection(AppConstants.Firestore.Collections.user)
                .document(userID)
                .updateData([
                    AppConstants.Firestore.UserData.name : name
                ])
            print("Document updated successfully")
        } catch {
            print("Error updating document: \(error.localizedDescription)")
        }
    }

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
        let saveButtonView = saveButtonContainer()

        let contentStack = UIStackView(arrangedSubviews: [personalView, editionView, saveButtonView])
        contentStack.axis = .vertical

        NSLayoutConstraint.activate([
            personalView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, multiplier: 0.4),
            editionView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, multiplier: 0.4),
            saveButtonView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, multiplier: 0.2),
        ])

        view.addSubViews([contentStack])

        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
        editionStack.distribution = .equalSpacing
        editionStack.spacing = 20

        let editionView = UIView()
        editionView.addSubViews([editionStack])

        NSLayoutConstraint.activate([
            editionStack.centerYAnchor.constraint(equalTo: editionView.centerYAnchor),
            editionStack.leadingAnchor.constraint(equalTo: editionView.leadingAnchor),
            editionStack.trailingAnchor.constraint(equalTo: editionView.trailingAnchor)
        ])

        return editionView
    }
    private func saveButtonContainer() -> UIView {
        let saveView = UIView()
        saveView.addSubViews([saveButton])

        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: saveView.centerYAnchor),
            saveButton.leadingAnchor.constraint(equalTo: saveView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: saveView.trailingAnchor),
        ])
        return saveView
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
