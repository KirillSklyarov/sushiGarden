//
//  Constants.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 20.06.2024.
//

import UIKit

struct AppConstants {

    struct Colors {
        static let background = UIColor(hexString: "000000")
        static let white = UIColor(hexString: "FFFFFF")
        static let red = UIColor(hexString: "C2182E")
        static let black = UIColor(hexString: "0F0F11")

        static let lightGray = UIColor(hexString: "F0F5FA")
        static let gray = UIColor(hexString: "5F5F5F")
        static let darkGray = UIColor(hexString: "29282C")
    }

    struct Fonts {
        static let bold14 = UIFont(name: "Sen-Regular_Bold", size: 14)
        static let bold16 = UIFont(name: "Sen-Regular_Bold", size: 16)
        static let bold19 = UIFont(name: "Sen-Regular_Bold", size: 19)
        static let bold28 = UIFont(name: "Sen-Regular_Bold", size: 28)
        static let bold34 = UIFont(name: "Sen-Regular_Bold", size: 34)
       
        static let regular12 = UIFont(name: "Sen-Regular", size: 12)
        static let regular14 = UIFont(name: "Sen-Regular", size: 14)
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

    struct Firestore {

        struct Collections {
            static let user = "user"
        }

        struct UserData {
            static let name = "name"
            static let email = "email"
        }

    }
}
