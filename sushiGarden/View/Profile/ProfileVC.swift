//
//  ProfileVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit
import Firebase

final class ProfileVC: BaseViewController {
    
    // MARK: - UI Properties
    private lazy var profilePhoto: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "photo"))
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    private lazy var nameLabel = WhiteBoldTitleLabel()
    private lazy var emailLabel = GrayRegularLabel()
    private lazy var ordersView = ProfileOrdersView(ordersID: ordersID)
    private lazy var profileCardsTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        return table
    }()
    private lazy var leaveButton = AppBlackButton()

    // MARK: - Other Properties
    var navManager: Coordinator?

    let data: [ProfileTableModel] = [
        ProfileTableModel(name: "Профиль", imageName: "user"),
        ProfileTableModel(name: "Карты", imageName: "card")
    ]

    let ordersID = ["111", "222", "333"]

    private let fireStore = Firestore.firestore()

    var currentUser: User?

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        dataBinding()
    }

    // MARK: - Private methods
    private func dataBinding() {
        Task {
            await loadDataFromFirebase()
            updateUI()
        }
    }

    private func updateUI() {
        let name = currentUser?.name ?? "123"
        let email = currentUser?.email ?? "123"
        nameLabel.updateTitle(name)
        emailLabel.updateTitle(email)
    }

    private func loadDataFromFirebase() async {
        do {
           let snapshot = try await fireStore.collection(AppConstants.Firestore.Collections.user).getDocuments()
            for doc in snapshot.documents {
                let data = doc.data()
               guard let name = data[AppConstants.Firestore.UserData.name] as? String,
                     let email = data[AppConstants.Firestore.UserData.email] as? String else { print("Casting problem"); return}
                print("name \(name)")
                print("email \(email)")

                let loadedUser = User(name: name, email: email, password: "")
                currentUser = loadedUser
                print(currentUser)

            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppConstants.Colors.background
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // Убираем слово "back" со следующего экрана
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        //  Меняем цвет шеврона back
        navigationController?.navigationBar.tintColor = .white
    }

    private func setupUI() {
        let personalStack = UIStackView(arrangedSubviews: [profilePhoto, nameLabel, emailLabel])
        personalStack.axis = .vertical
        personalStack.alignment = .center
        personalStack.spacing = 15

        let contentStack = UIStackView(arrangedSubviews: [personalStack, ordersView, profileCardsTable])
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 30

        view.addSubViews([contentStack, leaveButton])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            ordersView.heightAnchor.constraint(equalToConstant: 200),
            profileCardsTable.heightAnchor.constraint(equalToConstant: 110),

            leaveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leaveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell()}
        let item = data[indexPath.row]
        cell.configure(item: item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        let cellTitle = cell.nameLabel.text
        switch cellTitle {
        case "Профиль": navManager?.goToScreen(.editProfile)
        case "Карты": navManager?.goToScreen(.editCards)
        default: break
        }
    }

}

//MARK: - SwiftUI
import SwiftUI
struct ProviderProfile : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return ProfileVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = ProfileVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderProfile.ContainterView>) -> ProfileVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderProfile.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderProfile.ContainterView>) {

        }
    }
}
