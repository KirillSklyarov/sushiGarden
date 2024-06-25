//
//  ScreenFactory.swift
//  ToDoList
//
//  Created by Kirill Sklyarov on 11.06.2024.
//

import UIKit

enum NavigationScreens {
    case editProfile
    case editCards
}

final class Coordinator {

    var navController: UINavigationController?

    init(navController: UINavigationController?) {
        self.navController = navController
    }

    func goToScreen(_ screen: NavigationScreens) {
        var viewController: UIViewController?

        switch screen {
        case .editProfile:
            viewController = ScreenFactory.createScreen(.editProfile)
            navController?.pushViewController(viewController!, animated: true)
        case .editCards:
            viewController = EditCardsVC()
            navController?.pushViewController(viewController!, animated: true)
        }
    }
}
