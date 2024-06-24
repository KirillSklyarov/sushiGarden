//
//  AddressTextField+Picker.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class AddressTextFieldViewWithPicker: UIView {

    let paymentMethods = ["Оплата картой", "Оплата наличными"]

    private lazy var addressTextField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.Fonts.bold16
        field.textColor = AppConstants.Colors.titleWhite
        field.textAlignment = .left
        field.delegate = self
        return field
    }()

    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = AppConstants.Colors.catalogueGray
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return line
    }()

    private lazy var paymentPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = AppConstants.Colors.backgroundBlack
        return picker
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupView() {
        let toolbar = UIToolbar()
        toolbar.barTintColor = .clear
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)

        addressTextField.inputView = paymentPicker
        addressTextField.inputAccessoryView = toolbar

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

    @objc private func doneButtonTapped() {
        let selectedIndex = paymentPicker.selectedRow(inComponent: 0)
        let selectedTitle = paymentMethods[selectedIndex]
        addressTextField.text = selectedTitle
        addressTextField.resignFirstResponder()
    }
}

extension AddressTextFieldViewWithPicker: UITextFieldDelegate {

}

extension AddressTextFieldViewWithPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        paymentMethods.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        paymentMethods[row]
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = paymentMethods[row]

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppConstants.Colors.titleWhite]

        let attributedTitle = NSAttributedString(string: title, attributes: attributes)

        return attributedTitle
    }
}

