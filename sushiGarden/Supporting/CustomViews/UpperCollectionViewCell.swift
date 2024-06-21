//
//  UpperCollectionViewCell.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 21.06.2024.
//

import UIKit

final class UpperCollectionViewCell: UICollectionViewCell {

    static let identifier = "UpperCollectionViewCell"

    private lazy var rollImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 21
        image.clipsToBounds = true
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        contentView.addSubViews([rollImage])

        NSLayoutConstraint.activate([
            rollImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            rollImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rollImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rollImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(image: UIImage?) {
        guard let image else { return }
        rollImage.image = image
    }
}
