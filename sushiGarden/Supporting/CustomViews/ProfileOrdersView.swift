//
//  ProfileOrdersView.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 24.06.2024.
//

import UIKit

final class ProfileOrdersView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupView() {
        backgroundColor = AppConstants.Colors.white
        layer.cornerRadius = 21
        clipsToBounds = true
    }
}
