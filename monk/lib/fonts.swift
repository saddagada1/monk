//
//  fonts.swift
//  monk
//
//  Created by flighty on 2024-01-09.
//

import Foundation
import SwiftUI

public extension Font {
    static var title1: Font {
        return Font.custom("PPNeueMontreal-Bold", size: 48)
    }

    static var subTitle1: Font {
        return Font.custom("PPNeueMontreal-Book", size: 28)
    }

    static var subTitle2: Font {
        return Font.custom("PPNeueMontreal-Book", size: 22)
    }

    static var subTitle3: Font {
        return Font.custom("PPNeueMontreal-Book", size: 20)
    }

    static var header: Font {
        return Font.custom("PPNeueMontreal-Medium", size: 17)
    }

    static var paragraph: Font {
        return Font.custom("PPNeueMontreal-Book", size: 17)
    }

    static var label1: Font {
        return Font.custom("PPNeueMontreal-Book", size: 12)
    }

    static var label2: Font {
        return Font.custom("PPNeueMontreal-Book", size: 11)
    }
}
