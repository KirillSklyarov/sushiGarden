//
//  ScreenFactory.swift
//  ToDoList
//
//  Created by Kirill Sklyarov on 11.06.2024.
//

import UIKit

final class ScreenFactory {

    enum Screens {
        case Catalogue
        case Registration
        case TabBarController
    }

    static func createScreen(_ screen: Screens) -> UIViewController {
        var viewController: UIViewController?

        switch screen {
        case .TabBarController:
            viewController = TabBarController()
        case .Catalogue:
//            let presenter = MainPresenter()
            let viewController = CatalogueVC()
//            presenter.view = viewController as any MainVCProtocol
            return viewController
        case .Registration:
            let viewController = RegistrationVC()
            return viewController
        }
        if let viewController {
            return viewController
        } else {
            fatalError("Проблема с фабрикой экранов")
        }
    }
}
