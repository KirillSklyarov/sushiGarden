//
//  ScreenFactory.swift
//  ToDoList
//
//  Created by Kirill Sklyarov on 11.06.2024.
//

import UIKit

enum NavigationScreens {
    case EditProfile
    case EditCards
}

final class Coordinator {

    var navController: UINavigationController?

    init(navController: UINavigationController?) {
        self.navController = navController
    }

    func goToScreen(_ screen: NavigationScreens) {
        var viewController: UIViewController?

        switch screen {
        case .EditProfile:
            viewController = ScreenFactory.createScreen(.EditProfile)
            navController?.pushViewController(viewController!, animated: true)
        case .EditCards:
            viewController = EditCardsVC()
            navController?.pushViewController(viewController!, animated: true)
        }
    }
}
