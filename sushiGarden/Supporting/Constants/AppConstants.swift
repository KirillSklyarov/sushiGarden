//
//  Constants.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

struct AppConstants {

    struct Size {
        static let registrationViewHeight = CGFloat(664)
    }

    struct Colors {
        static let background = UIColor(hexString: "000000")
        static let white = UIColor(hexString: "FFFFFF")
        static let red = UIColor(hexString: "C2182E")
        static let black = UIColor(hexString: "0F0F11")

        static let gray = UIColor(hexString: "F0F5FA")
        static let darkGray = UIColor(hexString: "646982")

        static let agreementGray = UIColor(hexString: "7E8A97")
        static let tabBarGray = UIColor(hexString: "4C4C4C")
        static let catalogueGray = UIColor(hexString: "5F5F5F")
        static let detailDarkGray = UIColor(hexString: "29282C")
        static let extrasGray = UIColor(hexString: "8E8E8E")

    }

    struct Fonts {
        static let bold14 = UIFont(name: "Sen-Regular_Bold", size: 14)
        static let bold16 = UIFont(name: "Sen-Regular_Bold", size: 16)
        static let bold18 = UIFont(name: "Sen-Regular_Bold", size: 18)
        static let bold19 = UIFont(name: "Sen-Regular_Bold", size: 19)
        static let bold28 = UIFont(name: "Sen-Regular_Bold", size: 28)
        static let bold34 = UIFont(name: "Sen-Regular_Bold", size: 34)
       
        static let regular12 = UIFont(name: "Sen-Regular", size: 12)
        static let regular14 = UIFont(name: "Sen-Regular", size: 14)
        static let regular15 = UIFont(name: "Sen-Regular", size: 15)
        static let regular16 = UIFont(name: "Sen-Regular", size: 16)
        static let regular18 = UIFont(name: "Sen-Regular", size: 18)

    }

    enum AppFonts {
        case bold16
        case bold19
        case bold34

        var font: UIFont {
            switch self {
            case .bold16: return UIFont(name: "Sen-Regular_Bold", size: 16)!
            case .bold19: return UIFont(name: "Sen-Regular_Bold", size: 19)!
            case .bold34: return UIFont(name: "Sen-Regular_Bold", size: 34)!
            }
        }


    }
}
