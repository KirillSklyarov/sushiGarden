//
//  Constants.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

struct Constants {

    struct AppSize {
        static let registrationViewHeight = CGFloat(664)
    }

    struct AppColors {
        static let backgroundBlack = UIColor(hexString: "000000")
        static let titleWhite = UIColor(hexString: "FFFFFF")
        static let textBlack = UIColor(hexString: "0F0F11")
        static let textFieldGray = UIColor(hexString: "F0F5FA")
        static let agreementGray = UIColor(hexString: "7E8A97")
        static let buttonRed = UIColor(hexString: "C2182E")
        static let textDarkGray = UIColor(hexString: "646982")


    }

    struct AppFonts {
        static let bold16 = UIFont(name: "Sen-Regular_Bold", size: 16)
        static let bold34 = UIFont(name: "Sen-Regular_Bold", size: 34)
       
        static let regular14 = UIFont(name: "Sen-Regular", size: 15)
        static let regular15 = UIFont(name: "Sen-Regular", size: 15)
        static let regular16 = UIFont(name: "Sen-Regular", size: 16)
        static let regular18 = UIFont(name: "Sen-Regular", size: 18)

    }
}
