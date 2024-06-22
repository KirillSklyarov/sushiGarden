//
//  CatalogueVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

struct sushiDetail {
    let name: String
    let weight: Int
    let price: Int
    let photoName: String
}

class CatalogueVC: BaseViewController {

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.delegate = self
        collection.register(UpperCollectionViewCell.self, forCellWithReuseIdentifier: UpperCollectionViewCell.identifier)
        collection.register(CatNamesCollectionViewCell.self, forCellWithReuseIdentifier: CatNamesCollectionViewCell.identifier)
        collection.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()

    let images = [UIImage(named: "roll1"), UIImage(named: "roll2")]
    let categoryNames = ["Суши", "Роллы", "Горячие роллы", "Салаты", "WOK"]
    let sushiDetailData: [sushiDetail] = [
        sushiDetail(name: "Хикари", weight: 255, price: 620, photoName: "detail1"),
        sushiDetail(name: "Лос-Анджелес", weight: 285, price: 707, photoName: "detail2"),
        sushiDetail(name: "Филадельфия", weight: 300, price: 800, photoName: "detail3"),
        sushiDetail(name: "Калифорния", weight: 275, price: 920, photoName: "detail4"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { [weak self] (sectionIndex: Int, _) in
            guard let self else { fatalError("234234")}
            switch sectionIndex {
            case 0: return self.createFirstSection()
            case 1: return self.createSecondSection()
            case 2: return self.createDetailSection()
            default: fatalError("12312313")
            }
        }
        return layout
    }

    private func createFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 7)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.25))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 16, leading: 32, bottom: 16, trailing: 0)

        return section
    }

    private func createSecondSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(70),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 5)
        group.interItemSpacing = .fixed(13)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 22)
        return section
    }

    private func createDetailSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.45))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(8)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

extension CatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return images.count
        case 1: return categoryNames.count
        case 2: return sushiDetailData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpperCollectionViewCell.identifier, for: indexPath) as? UpperCollectionViewCell else { return UICollectionViewCell() }
            let cellImage = images[indexPath.row]
            cell.configure(image: cellImage)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatNamesCollectionViewCell.identifier, for: indexPath) as? CatNamesCollectionViewCell else { return UICollectionViewCell() }
            let cellName = categoryNames[indexPath.row]
            cell.configure(name: cellName)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
            let item = sushiDetailData[indexPath.row]
            cell.configure(image: item.photoName, name: item.name, weight: item.weight, price: item.price)
            return cell
        default: return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 2: print("Hooray")
            let newScreen = DetailViewController()
            let _ = UINavigationController(rootViewController: newScreen)
            navigationController?.pushViewController(newScreen, animated: true)
        default: print("nothing")
        }
    }
}


//MARK: - SwiftUI
import SwiftUI
struct ProviderCatalogue : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return CatalogueVC()
        }

        typealias UIViewControllerType = UIViewController


        let viewController = CatalogueVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderCatalogue.ContainterView>) -> CatalogueVC {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderCatalogue.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderCatalogue.ContainterView>) {

        }
    }
}
