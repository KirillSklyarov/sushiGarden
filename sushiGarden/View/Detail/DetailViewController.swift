//
//  DetailViewController.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 21.06.2024.
//

import UIKit

class DetailViewController: BaseViewController {

    let sushiDetailData = sushiDetail(name: "Хикари", weight: 255, price: 620, photoName: "detail1")

    let desc = "креветка в темпуре, спайси тартар из тунца и лосося, рис для суси, нори, трюфельное масло, авокадо, темпура и тобико, васаби (9 шт.)"

    private lazy var sushiImage: UIImageView = {
        let image = UIImageView()
        let sushi = sushiDetailData.photoName
        image.image = UIImage(named: sushi)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.heightAnchor.constraint(equalToConstant: 373).isActive = true
        image.widthAnchor.constraint(equalToConstant: 380).isActive = true
        return image
    }()

    private func descriptionStack() -> UIStackView {
        lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Описание"
            label.font = AppConstants.Fonts.bold16
            label.textColor = AppConstants.Colors.gray
            label.textAlignment = .left
            label.numberOfLines = 1
            return label
        }()
        lazy var ingredientsLabel: UILabel = {
            let label = UILabel()
            label.text = desc
            label.font = AppConstants.Fonts.regular14
            label.textColor = AppConstants.Colors.white
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()

        let stack = UIStackView(arrangedSubviews: [descriptionLabel, ingredientsLabel])
        stack.axis = .vertical
        stack.spacing = 10

        return stack
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupContentStack() -> UIStackView {
        let nameStack = NameAndWeightStack(name: sushiDetailData.name, weight: sushiDetailData.weight, price: sushiDetailData.price, nameFontSize: .bold19, secondaryLabel: .price)
        let counter = CustomStepper(width: 171)

        let nameAndStepperStack = UIStackView(arrangedSubviews: [nameStack, counter])
        nameAndStepperStack.axis = .horizontal
        nameAndStepperStack.alignment = .center

        let lineView: UIView = {
            let view = UIView()
            view.backgroundColor = AppConstants.Colors.darkGray
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            return view
        }()

        let descriptionStack = descriptionStack()

        let stack = UIStackView(arrangedSubviews: [sushiImage, nameAndStepperStack, lineView, descriptionStack])
        stack.axis = .vertical
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }

    private func setupUI() {
        let addressHeader = addressHeaderForCatalogueVC()
        let contentStack = setupContentStack()

        view.addSubViews([addressHeader, contentStack])

        NSLayoutConstraint.activate([
            addressHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addressHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressHeader.heightAnchor.constraint(equalToConstant: 45),

            contentStack.topAnchor.constraint(equalTo: addressHeader.bottomAnchor, constant: 13),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderDetail : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return DetailViewController()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = DetailViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderDetail.ContainterView>) -> DetailViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderDetail.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderDetail.ContainterView>) {

        }
    }
}
