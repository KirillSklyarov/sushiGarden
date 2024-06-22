//
//  CustomStepper.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 22.06.2024.
//

import UIKit

class CustomStepper: UIStackView {

    private var count = 0 {
        didSet {
            if count >= 0 {
                countLabel.text = "\(count)"
            } else {
                count = 0
            }
        }
    }

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(count)"
        label.font = AppConstants.Fonts.bold19
        label.textColor = AppConstants.Colors.titleWhite
        label.textAlignment = .center
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = AppConstants.Fonts.bold19
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = AppConstants.Fonts.bold19
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupCustomStepper()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func minusButtonTapped(sender: UIButton) {
        count -= 1
    }

    @objc private func plusButtonTapped(sender: UIButton) {
        count += 1
    }


    func setupCustomStepper() {
        addArrangedSubview(minusButton)
        addArrangedSubview(countLabel)
        addArrangedSubview(plusButton)
        axis = .horizontal
        distribution = .fillEqually
        backgroundColor = AppConstants.Colors.detailDarkGray
        layer.cornerRadius = 12
        clipsToBounds = true

        widthAnchor.constraint(equalToConstant: 177).isActive = true
    }
}