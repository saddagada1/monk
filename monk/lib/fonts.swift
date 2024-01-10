//
//  font.swift
//  monk
//
//  Created by flighty on 2024-01-09.
//

import Foundation
import SwiftUI

extension Font {
    public static var title1: Font {
        return Font.custom("PPNeueMontreal-Bold", size: 48);
    }
    public static var subTitle1: Font {
        return Font.custom("PPNeueMontreal-Book", size: 28);
    }
    public static var subTitle2: Font {
        return Font.custom("PPNeueMontreal-Book", size: 22);
    }
    public static var subTitle3: Font {
        return Font.custom("PPNeueMontreal-Book", size: 20);
    }
    public static var header: Font {
        return Font.custom("PPNeueMontreal-Medium", size: 17);
    }
    public static var paragraph: Font {
        return Font.custom("PPNeueMontreal-Book", size: 17);
    }
    public static var label1: Font {
        return Font.custom("PPNeueMontreal-Book", size: 12);
    }
    public static var label2: Font {
        return Font.custom("PPNeueMontreal-Book", size: 11);
    }
}
