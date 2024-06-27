//
//  ScreenFactory.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 25.06.2024.
//

import UIKit

enum Screens {
    case registration
    case logIn
    case tabBarController
    case catalogue
    case promo
    case orders
    case cart
    case profile
    case editProfile
    case editCards
    case sushiDetail
}

final class ScreenFactory {

    static func createScreen(_ screen: Screens, coordinator: Coordinator? = nil) -> UIViewController {

        switch screen {
        case .tabBarController:
            return TabBarController()
        case .registration:
            let viewController = RegistrationVC()
            let navController = UINavigationController(rootViewController: viewController)
            let coordinator = Coordinator(navController: navController)
            viewController.coordinator = coordinator
            return navController
        case .logIn:
            let viewController = LoginVC(coordinator: coordinator)
            return viewController
        case .catalogue:
            let viewController = CatalogueVC()
            let navController = UINavigationController(rootViewController: viewController)
            let navManager = Coordinator(navController: navController)
            viewController.coordinator = navManager
            return navController
        case .promo:
            let promoVC = PromoVC()
            return UINavigationController(rootViewController: promoVC)
        case .orders:
            let ordersVC = OrdersVC()
            return UINavigationController(rootViewController: ordersVC)
        case .cart:
            let cartVC = CartVC()
            return UINavigationController(rootViewController: cartVC)
        case .profile:
            let profileVC = ProfileVC()
            let navController = UINavigationController(rootViewController: profileVC)
            let coordinator = Coordinator(navController: navController)
            profileVC.coordinator = coordinator
            return navController
        case .editProfile:
            return EditProfileVC()
        case .editCards:
            return EditCardsVC()
        case .sushiDetail:
            return DetailViewController()
        }
    }
}
