//
//  AddressVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 23.06.2024.
//

import UIKit

final class AddressVC: BaseViewController {

    private lazy var addressTitleLabel = AddressLabel(title: "Адрес")
    private lazy var personalTitleLabel = AddressLabel(title: "Кому")
    private lazy var paymentTitleLabel = AddressLabel(title: "Оплата")

    private lazy var streetTextField = AddressTextFieldView(placeholderText: "Город, улица")
    private lazy var blockTextField = AddressTextFieldView(placeholderText: "Корпус")
    private lazy var officeTextField = AddressTextFieldView(placeholderText: "Кв./ Офис")
    private lazy var floorTextField = AddressTextFieldView(placeholderText: "Этаж")
    private lazy var intercomTextField = AddressTextFieldView(placeholderText: "Домофон")
    
    private lazy var nameTextField = AddressTextFieldView(placeholderText: "Ваше имя")
    private lazy var phoneTextField = AddressTextFieldView(placeholderText: "Телефон")
    private lazy var emailTextField = AddressTextFieldView(placeholderText: "Почта")

    private lazy var paymentTextField = AddressTextFieldView(placeholderText: "")

    private lazy var paymentPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()

    private lazy var testPickerView = AddressTextFieldViewWithPicker()

    let paymentMethods = ["Оплата картой", "Оплата наличными"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupAddressStack() -> UIStackView {
        let leftStack = UIStackView(arrangedSubviews: [blockTextField, officeTextField])
        leftStack.axis = .vertical
        leftStack.spacing = 20

        let rightStack = UIStackView(arrangedSubviews: [floorTextField, intercomTextField])
        rightStack.axis = .vertical
        rightStack.spacing = 20

        let detailAddressStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        detailAddressStack.axis = .horizontal
        detailAddressStack.distribution = .fillEqually
        detailAddressStack.spacing = 30

        let basicAddressStack = UIStackView(arrangedSubviews: [addressTitleLabel, streetTextField, detailAddressStack])
        basicAddressStack.axis = .vertical
        basicAddressStack.spacing = 30

        return basicAddressStack
    }

    private func setupPersonalStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [personalTitleLabel, nameTextField, phoneTextField, emailTextField])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }

    private func setupUI() {
        let addressStack = setupAddressStack()
        let personalStack = setupPersonalStack()

        let contentStack = UIStackView(arrangedSubviews: [addressStack, personalStack, paymentTitleLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 30

//        let test = UITextField()
//        test.inputView = paymentPicker

//        paymentTextField.inputView = paymentPicker

        view.addSubViews([contentStack, testPickerView])

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            testPickerView.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 20),
            testPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            testPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
}

extension AddressVC: UITextFieldDelegate {

}

extension AddressVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        paymentMethods.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        paymentMethods[row]
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderAddress : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return AddressVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = AddressVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderAddress.ContainterView>) -> AddressVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderAddress.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderAddress.ContainterView>) {

        }
    }
}
