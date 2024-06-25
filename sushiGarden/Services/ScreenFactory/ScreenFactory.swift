//
//  ScreenFactory.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 25.06.2024.
//

import UIKit

enum Screens {
    case registration
    case tabBarController
    case catalogue
    case promo
    case orders
    case cart
    case profile
    case editProfile
    case editCards
}

final class ScreenFactory {

    static func createScreen(_ screen: Screens) -> UIViewController {

        switch screen {
        case .tabBarController:
            return TabBarController()
        case .registration:
            return RegistrationVC()
        case .catalogue:
            let catVC = CatalogueVC()
            return UINavigationController(rootViewController: catVC)
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
            let navManager = Coordinator(navController: navController)
            profileVC.navManager = navManager
            return navController
        case .editProfile:
            return EditProfileVC()
        case .editCards:
            return EditCardsVC()
        }
    }
}
