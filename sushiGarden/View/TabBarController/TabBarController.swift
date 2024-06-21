//
//  ViewController.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.tintColor = AppConstants.Colors.titleWhite
        tabBar.unselectedItemTintColor = AppConstants.Colors.tabBarGray

        let catalogue = UINavigationController(rootViewController: CatalogueVC())
        let promo = UINavigationController(rootViewController: PromoVC())
        let orders = UINavigationController(rootViewController: OrdersVC())
        let cart = UINavigationController(rootViewController: CartVC())
        let profile = UINavigationController(rootViewController: ProfileVC())

        let catalogueImage = UIImage(named: "catalogue")
        let promoImage = UIImage(named: "promo")
        let ordersImage = UIImage(named: "orders")
        let cartImage = UIImage(named: "cart")
        let profileImage = UIImage(named: "profile")

        catalogue.tabBarItem = UITabBarItem(title: "Каталог", image: catalogueImage, tag: 0)
        promo.tabBarItem = UITabBarItem(title: "Акции", image: promoImage, tag: 1)
        orders.tabBarItem = UITabBarItem(title: "Заказы", image: ordersImage, tag: 2)
        cart.tabBarItem = UITabBarItem(title: "Корзина", image: cartImage, tag: 3)
        profile.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, tag: 4)

        viewControllers = [catalogue, promo, orders, cart, profile]
    }
}
