//
//  ProfileOrdersView.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class ProfileOrdersView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои заказы"
        label.font = AppConstants.Fonts.bold16
        return label
    }()

    private lazy var ordersTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = 40
        return table
    }()

    var ordersID = [String]()

    init(ordersID: [String]) {
        super.init(frame: .zero)
        setupView()
        self.ordersID = ordersID
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = AppConstants.Colors.white
        layer.cornerRadius = 21
        clipsToBounds = true

        addSubViews([titleLabel, ordersTable])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            ordersTable.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20),
            ordersTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ordersTable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            ordersTable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

extension ProfileOrdersView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ordersID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = AppConstants.Fonts.regular14

        let item = ordersID[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
}
