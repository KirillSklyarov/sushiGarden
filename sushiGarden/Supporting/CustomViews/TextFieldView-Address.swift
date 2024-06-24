//
//  TextFieldView-Address.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class AddressTextFieldView: UIView {

    private func setupAddressTextField(placeholderText: String) -> UITextField {
        let field = UITextField()
        field.font = AppConstants.Fonts.bold16
        field.textColor = AppConstants.Colors.titleWhite
        field.textAlignment = .left
        field.delegate = self

        // Тут настраиваем кастомный плейхолдер
        let placeholderText = placeholderText
        let placeholderColor = AppConstants.Colors.tabBarGray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: AppConstants.Fonts.regular16 ?? .systemFont(ofSize: 16)
        ]
        field.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        return field
    }

    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = AppConstants.Colors.catalogueGray
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return line
    }()

    init(placeholderText: String) {
        super.init(frame: .zero)
        setupView(placeholderText: placeholderText)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupView(placeholderText: String) {
        let addressTextField = setupAddressTextField(placeholderText: placeholderText)
        let contentStack = UIStackView(arrangedSubviews: [addressTextField, lineView])
        contentStack.axis = .vertical
        contentStack.spacing = 6

        addSubViews([contentStack])
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension AddressTextFieldView: UITextFieldDelegate {

}

