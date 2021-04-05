//
//  Font.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-03-31.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit

struct Font {
    enum Roboto: String {
        case thin = "Thin"
        case regular = "Regular"
        case medium = "Medium"
        case light = "Light"
        case bold = "Bold"

        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: "Roboto-\(self.rawValue)", size: size)!
        }
    }
}

extension Font {
    static var titleStrong: UIFont {
        Font.Roboto.bold.size(25)
    }
    static var headingStrong: UIFont {
        Font.Roboto.bold.size(18)
    }

    static var subHeadingStrong: UIFont {
        Font.Roboto.bold.size(17)
    }

    static var subHeadingRegular: UIFont {
        Font.Roboto.bold.size(16)
    }

    static var bodyStrong: UIFont {
        Font.Roboto.medium.size(16)
    }
    
    static var bodyRegular: UIFont {
        Font.Roboto.regular.size(16)
    }

    static var captionBold: UIFont {
        Font.Roboto.regular.size(13)
    }

    static var captionRegular: UIFont {
        Font.Roboto.light.size(14)
    }

    static var navStrong: UIFont {
        Font.Roboto.bold.size(10)
    }

    static var navReglar: UIFont {
        Font.Roboto.medium.size(10)
    }
}
