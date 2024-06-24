//
//  UIView+Ext.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

extension UIView {

    func addSubViews(_ subviews: [UIView]) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func setupEnterButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Войти".uppercased(), for: .normal)
        button.backgroundColor = AppConstants.Colors.red
        button.titleLabel?.font = AppConstants.Fonts.bold16
        button.heightAnchor.constraint(equalToConstant: 71).isActive = true
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        return button
    }
}
