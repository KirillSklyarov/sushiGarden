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
        self.view.backgroundColor = AppConstants.Colors.background
    }

    func showAlert(emptyFields: String) {
        let alert = UIAlertController(title: "Ошибка", message: "У вас не заполнены следующие поля: \n\(emptyFields)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Отменить", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
