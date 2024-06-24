//
//  AppRedButton.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class AppRedButton: UIButton {

    let buttonHeight = CGFloat(53)

    init(title: String) {
        super.init(frame: .zero)
        setupRedButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRedButton(title: String) {
        setTitle(title.uppercased(), for: .normal)
        titleLabel?.font = AppConstants.Fonts.bold16
        titleLabel?.textColor = AppConstants.Colors.white
        backgroundColor = AppConstants.Colors.red
        layer.cornerRadius = 17
        clipsToBounds = true

        heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
}
