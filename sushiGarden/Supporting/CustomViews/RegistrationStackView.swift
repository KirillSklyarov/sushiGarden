//
//  RegistrationStackView.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

final class RegistrationStackView: UIStackView {

    let textfieldHeight = CGFloat(60)
    var textFieldText = ""

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя".uppercased()
        label.font = AppConstants.Fonts.regular16
        label.textColor = AppConstants.Colors.black
        return label
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Александр"
        field.heightAnchor.constraint(equalToConstant: textfieldHeight).isActive = true
        field.backgroundColor = AppConstants.Colors.lightGray
        field.layer.cornerRadius = 11
        field.layer.masksToBounds = true

        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: field.bounds.height))
        field.leftView = leftPadding
        field.leftViewMode = .always
        return field
    }()

    init(name: String, placeholder: String) {
        super.init(frame: .zero)
        setupFields(name: name, placeholder: placeholder)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupFields(name: String, placeholder: String) {
        headerLabel.text = name
        textField.placeholder = placeholder
        if name == "Пароль" {
            textField.isSecureTextEntry = true
        }
    }

    private func setupStackView() {
        textField.delegate = self

        addArrangedSubview(headerLabel)
        addArrangedSubview(textField)
        axis = .vertical
        spacing = 10
        backgroundColor = .clear
        heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
}

extension RegistrationStackView: UITextFieldDelegate {

    // В этом методе мы настраиваем что делать с текстом
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldText = textField.text?.capitalized ?? ""
    }

    // После того как мы нажали на другую кнопку обнуляет строку - удобно и правильно
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldText = textField.text?.capitalized ?? ""
    }

    // В этом методе мы настраиваем что делать при нажатии на кнопку Return
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        saveDataToFireStore()
//        chatTextField.text = ""
//        return true
//    }
}
