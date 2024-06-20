//
//  RegistrationStackView.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

class RegistrationStackView: UIStackView {

    let textfieldHeight = CGFloat(60)

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя".uppercased()
        label.font = Constants.AppFonts.regular15
        label.textColor = Constants.AppColors.textBlack
        return label
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Александр"
        field.heightAnchor.constraint(equalToConstant: textfieldHeight).isActive = true
        field.backgroundColor = Constants.AppColors.textFieldGray
        field.layer.cornerRadius = 11
        field.layer.masksToBounds = true

        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: field.bounds.height))
        field.leftView = leftPadding
        field.leftViewMode = .always
        return field
    }()

    init(name: String, placeholder: String) {
        super.init(frame: .zero)
        headerLabel.text = name
        textField.placeholder = placeholder
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }
    
    func setupStackView() {
        addArrangedSubview(headerLabel)
        addArrangedSubview(textField)
        axis = .vertical
        spacing = 10
        backgroundColor = .clear
        heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
}
