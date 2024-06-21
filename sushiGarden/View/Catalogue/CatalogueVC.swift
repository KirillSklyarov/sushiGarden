//
//  CatalogueVC.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

class CatalogueVC: BaseViewController {

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func createLayout() -> UICollectionViewLayout {

    }


    private func setupUI() {
        let addressHeader = addressHeaderForCatalogueVC()

        view.addSubViews([addressHeader])

        NSLayoutConstraint.activate([
            addressHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addressHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressHeader.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

extension CatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
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
