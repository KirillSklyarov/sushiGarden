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
    case sushiDetail
    case tabBar
    case logIn
}

final class Coordinator {

    var navController: UINavigationController?

    init(navController: UINavigationController?) {
        self.navController = navController
    }

    func goToScreen(_ screen: NavigationScreens) {
        guard let navController else {
            print("Ошибка: navController не инициализирован")
            return
        }

        let viewController = {
            switch screen {
            case .editProfile: ScreenFactory.createScreen(.editProfile)
            case .editCards: ScreenFactory.createScreen(.editCards)
            case .sushiDetail: ScreenFactory.createScreen(.sushiDetail)
            case .tabBar: ScreenFactory.createScreen(.tabBarController)
            case .logIn: ScreenFactory.createScreen(.logIn)
            }
        }()

        if screen == .logIn {
            navController.modalPresentationStyle = .fullScreen
            navController.present(viewController, animated: true)
        } else {
            navController.pushViewController(viewController, animated: true)
        }
    }

    func changeRootVCToTabBar() {
        let tabbarVC = ScreenFactory.createScreen(.tabBarController)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else { print("Smth's going wrong"); return }

        sceneDelegate.window?.rootViewController = tabbarVC
    }
}
