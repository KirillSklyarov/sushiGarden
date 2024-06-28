//
//  TextFieldView-Address.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class TextFieldAndLineView: UIView {

    var text = ""

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.Fonts.bold16
        field.textColor = AppConstants.Colors.white
        field.textAlignment = .left
        field.delegate = self

        // Тут настраиваем кастомный плейхолдер
        let placeholderText = ""
        let placeholderColor = AppConstants.Colors.darkGray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: AppConstants.Fonts.regular16 ?? .systemFont(ofSize: 16)
        ]
        field.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        return field
    }()


    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = AppConstants.Colors.darkGray
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
        textField.placeholder = placeholderText

        let contentStack = UIStackView(arrangedSubviews: [textField, lineView])
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

    func updateTitle(_ text: String) {
        textField.text = text
    }

    func resign() {
        textField.resignFirstResponder()
    }
}

extension TextFieldAndLineView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        text = textField.text ?? ""
    }
}

