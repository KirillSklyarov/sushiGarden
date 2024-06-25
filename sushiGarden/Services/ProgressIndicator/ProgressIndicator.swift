//
//  ProgressIndicator.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 25.06.2024.
//

import Foundation
import ProgressHUD

struct ProgressIndicator {

    static func show() {
        ProgressHUD.colorProgress = .red
        ProgressHUD.progress("User is singing in", 1.0)
    }

    static func succeed() {
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.succeed()
    }

    static func dismiss() {
        ProgressHUD.dismiss()
    }
}

