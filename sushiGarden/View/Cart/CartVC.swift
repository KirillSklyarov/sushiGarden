//
//  CartVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

final class CartVC: BaseViewController {

    private lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.font = AppConstants.Fonts.bold28
        label.textColor = AppConstants.Colors.titleWhite
        return label
    }()

    private lazy var itemsLabel: UILabel = {
        let label = UILabel()
        label.text = "3 позиции / 630 гр."
        label.font = AppConstants.Fonts.regular16
        label.textColor = AppConstants.Colors.tabBarGray
        return label
    }()

    private lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cartLabel, itemsLabel])
        stack.axis = .vertical
        return stack
    }()

    private lazy var cartTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.separatorColor = .white
        table.allowsSelection = false
        table.isScrollEnabled = false
        return table
    }()

    private lazy var extraTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ExtrasTableViewCell.self, forCellReuseIdentifier: ExtrasTableViewCell.identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.separatorColor = .white
        table.allowsSelection = false
        table.isScrollEnabled = false
        return table
    }()

    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить еще"
        label.font = AppConstants.Fonts.bold16
        label.textColor = AppConstants.Colors.titleWhite
        return label
    }()

    private lazy var makeOrderView: MakeOrderView = {
        let view = MakeOrderView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(orderButtonTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()

    let sushiDetailData: [sushiDetail] = [
        sushiDetail(name: "Хикари", weight: 255, price: 620, photoName: "detail1"),
        sushiDetail(name: "Лос-Анджелес", weight: 285, price: 707, photoName: "detail2"),
        sushiDetail(name: "Филадельфия", weight: 300, price: 800, photoName: "detail3"),
    ]

//    sushiDetail(name: "Калифорния", weight: 275, price: 920, photoName: "detail4"),

    let extrasData: [extrasDetail] = [
        extrasDetail(name: "Васаби", weight: 10, price: 60, imageName: "extras1"),
        extrasDetail(name: "Имбирь", weight: 30, price: 60, imageName: "extras2"),
        extrasDetail(name: "Соевый соус", weight: 30, price: 60, imageName: "extras3")
    ]

    var cartTableHeight: CGFloat {
        CGFloat(sushiDetailData.count * 133)
    }

    var extrasTableHeight: CGFloat {
        CGFloat(extrasData.count * 75)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        setupNavigation()
    }

    @objc private func orderButtonTapped() {
        let addressVC = AddressVC()
        navigationController?.pushViewController(addressVC, animated: false)
    }

    private func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppConstants.Colors.backgroundBlack
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupUI() {
        view.addSubViews([scrollView])

        scrollView.contentInsetAdjustmentBehavior = .never

//        contentView.backgroundColor = .blue

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        scrollView.addSubViews([contentView])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        contentView.addSubViews([headerStack, cartTable, addLabel, extraTable, makeOrderView])

        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            cartTable.topAnchor.constraint(equalTo: headerStack.bottomAnchor),
            cartTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cartTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartTable.heightAnchor.constraint(equalToConstant: cartTableHeight),

            addLabel.topAnchor.constraint(equalTo: cartTable.bottomAnchor, constant: 20),
            addLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            addLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            extraTable.topAnchor.constraint(equalTo: addLabel.bottomAnchor, constant: 10),
            extraTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            extraTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            extraTable.heightAnchor.constraint(equalToConstant: extrasTableHeight),

            makeOrderView.topAnchor.constraint(equalTo: extraTable.bottomAnchor, constant: 20),
            makeOrderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            makeOrderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            makeOrderView.heightAnchor.constraint(equalToConstant: 53),

            makeOrderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cartTable {
            return sushiDetailData.count
        } else {
            return extrasData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cartTable {
            return configureOrderCell(tableView: tableView, indexPath: indexPath)
        } else {
            return configureExtrasCell(tableView: tableView, indexPath: indexPath)
        }
    }

    private func configureOrderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else { print("123123123"); return UITableViewCell() }
        let cartItem = sushiDetailData[indexPath.row]
        cell.configure(image: cartItem.photoName, name: cartItem.name, price: cartItem.price)
        return cell
    }

    private func configureExtrasCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExtrasTableViewCell.identifier, for: indexPath) as? ExtrasTableViewCell else { print("123123123"); return UITableViewCell() }
        let extraItem = extrasData[indexPath.row]
        cell.configure(item: extraItem)
        return cell
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderCart : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return CartVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = CartVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderCart.ContainterView>) -> CartVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderCart.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderCart.ContainterView>) {

        }
    }
}
