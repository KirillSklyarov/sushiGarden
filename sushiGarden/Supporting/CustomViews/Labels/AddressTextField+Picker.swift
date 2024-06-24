//
//  AddressTextField+Picker.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class AddressTextFieldViewWithPicker: UIView {

    let paymentMethods: [PaymentsMethods] = [
        PaymentsMethods(name: "Оплата картой", imageName: "creditcard"),
        PaymentsMethods(name: "Оплата наличными", imageName: "dollarsign.circle")
    ]

    private lazy var addressTextField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.Fonts.bold16
        field.textColor = AppConstants.Colors.titleWhite
        field.textAlignment = .left
        field.delegate = self

        let rightChevron = UIImageView()
        let chevron = UIImage(named: "chevronDown")
        rightChevron.image = chevron

        field.rightView = rightChevron
        field.rightViewMode = .always

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
        addressTextField.text = selectedTitle.name

        let imageName = paymentMethods[selectedIndex].imageName
        let image = UIImage(systemName: imageName)?.withTintColor(AppConstants.Colors.titleWhite, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .left

        addressTextField.leftView = imageView
        addressTextField.leftViewMode = .always

        addressTextField.resignFirstResponder()
    }
}

extension AddressTextFieldViewWithPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        paymentMethods.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        paymentMethods[row].name
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerView = setupPickerView(row: row)
        return pickerView
    }

    private func setupPickerView(row: Int) -> UIView {
        let pickerView = UIView()

        let imageView = UIImageView()
        let imageName = paymentMethods[row].imageName
        let image = UIImage(systemName: imageName)?.withTintColor(AppConstants.Colors.titleWhite, renderingMode: .alwaysOriginal)
        imageView.contentMode = .center
        imageView.image = image

        let label = UILabel()
        label.text = paymentMethods[row].name
        label.font = AppConstants.Fonts.regular16
        label.textColor = AppConstants.Colors.titleWhite

        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .horizontal
        stack.spacing = 10

        pickerView.addSubViews([stack])

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: pickerView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor)
        ])
        return pickerView
    }
}

extension AddressTextFieldViewWithPicker: UITextFieldDelegate {

}
