//
//  ScreenFactory.swift
//  ToDoList
//
//  Created by Kirill Sklyarov on 11.06.2024.
//

import UIKit

final class ScreenFactory {

    enum Screens {
        case Main
        case Registration
    }

    static func createScreen(_ screen: Screens) -> UIViewController {
        switch screen {
        case .Main:
            let presenter = MainPresenter()
            let viewController = MainViewController(presenter: presenter)
            presenter.view = viewController as any MainVCProtocol
            return viewController
        case .Registration:
            let viewController = RegistrationVC()
            return viewController
        }
    }
}
