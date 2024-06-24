//
//  PromoVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

struct CategoryData {
    let categoryName: String
    let images: [UIImage?]
}

class PromoVC: BaseViewController {

    let imagesSection1 = [UIImage(named: "roll1"), UIImage(named: "roll2")]
    let imagesSection2 = [UIImage(named: "roll3"), UIImage(named: "roll1")]
    let imagesSection3 = [UIImage(named: "roll4")]

    var promoData = [CategoryData]()

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.delegate = self
        collection.register(UpperCollectionViewCell.self, forCellWithReuseIdentifier: UpperCollectionViewCell.identifier)
        collection.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collection.backgroundColor = .clear
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        promoData = [
            CategoryData(categoryName: "Постное меню", images: imagesSection1),
            CategoryData(categoryName: "Сеты", images: imagesSection2),
            CategoryData(categoryName: "Еще сеты", images: imagesSection3)]
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { [weak self] (sectionIndex: Int, _) in
            guard let self else { fatalError("234234")}
            return  self.createFirstSection()
        }
        return layout
    }

    private func createFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 7)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.27))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 16, leading: 32, bottom: 16, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]

        return section
    }

    private func setupUI() {
        let addressHeader = addressHeaderForCatalogueVC()

        view.addSubViews([addressHeader])
        view.addSubViews([collectionView])

        NSLayoutConstraint.activate([
            addressHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addressHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressHeader.heightAnchor.constraint(equalToConstant: 45),

            collectionView.topAnchor.constraint(equalTo: addressHeader.bottomAnchor, constant: 19),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension PromoVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        promoData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        promoData[section].images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpperCollectionViewCell.identifier, for: indexPath) as? UpperCollectionViewCell else { return UICollectionViewCell() }
        let section = promoData[indexPath.section]
        let cellImage = section.images[indexPath.row]
        cell.configure(image: cellImage)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView()}

        let section = promoData[indexPath.section]
        let sectionName = section.categoryName

        if kind == UICollectionView.elementKindSectionHeader {
            header.configureHeader(sectionName: sectionName)
        }
        return header
    }
}


//MARK: - SwiftUI
import SwiftUI
struct ProviderPromo : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return PromoVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = PromoVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderPromo.ContainterView>) -> PromoVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderPromo.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderPromo.ContainterView>) {

        }
    }
}
