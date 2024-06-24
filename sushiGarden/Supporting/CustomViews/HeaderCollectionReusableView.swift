//
//  HeaderCollectionReusableView.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 22.06.2024.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "HeaderCollectionReusableView"

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppConstants.Colors.white
        label.font = AppConstants.Fonts.bold16
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupHeader() {
        addSubViews([headerLabel])
    }

    func configureHeader(sectionName: String) {
        headerLabel.text = sectionName
    }
}
