//
//  ViewController.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

protocol MainVCProtocol: AnyObject {

}


final class MainViewController: UIViewController {

    private var presenter: MainPresenterProtocol

    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .red
    }

}

extension MainViewController: MainVCProtocol {
    
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderMain : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return MainViewController(presenter: MainPresenter())
        }

        typealias UIViewControllerType = UIViewController


        let viewController = MainViewController(presenter: MainPresenter())
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderMain.ContainterView>) -> MainViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: ProviderMain.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderMain.ContainterView>) {

        }
    }
}
