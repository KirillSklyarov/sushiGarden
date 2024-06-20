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
    }

    static func createScreen(_ screen: Screens) -> UIViewController {
        switch screen {
        case .Main:
            let presenter = MainPresenter()
            let viewController = MainViewController(presenter: presenter)
            presenter.view = viewController as any MainVCProtocol
            return viewController
        }
    }
}
