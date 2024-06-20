//
//  UIViewCont+Ext.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.AppColors.backgroundBlack
    }

    func setupEnterButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Войти".uppercased(), for: .normal)
        button.backgroundColor = Constants.AppColors.buttonRed
        button.titleLabel?.font = Constants.AppFonts.bold16
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        return button
    }
}
