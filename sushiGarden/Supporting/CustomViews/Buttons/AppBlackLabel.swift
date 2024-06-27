//
//  AppBlackButton.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class AppBlackLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBlackButton() {

        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withTintColor(AppConstants.Colors.red, renderingMode: .alwaysOriginal)
        let leaveImage = UIImageView(image: image)
        let title = UILabel()
        title.text = "Выйти"
        title.textColor = AppConstants.Colors.red
        title.font = AppConstants.Fonts.bold14
        let stack = UIStackView(arrangedSubviews: [leaveImage, title])
        stack.axis = .horizontal
        stack.spacing = 10

        addSubViews([stack])
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        isUserInteractionEnabled = true
        layer.cornerRadius = 32
        clipsToBounds = true
        layer.borderColor = AppConstants.Colors.white.cgColor
        layer.borderWidth = 1
        heightAnchor.constraint(equalToConstant: 55).isActive = true
        widthAnchor.constraint(equalToConstant: 286).isActive = true
    }
}
