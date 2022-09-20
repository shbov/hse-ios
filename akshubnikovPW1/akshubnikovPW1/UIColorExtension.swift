//
// Created by Andrew Shubnikov on 20.09.2022.
//

import UIKit

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: String!) {
        let scanner = Scanner(string: rgb)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "$+#")
        var hex: CUnsignedLongLong = 0

        if (!scanner.scanHexInt64(&hex)) {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }

        let r = (hex >> 16) & 0xFF;
        let g = (hex >> 8) & 0xFF;
        let b = (hex) & 0xFF;

        self.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: 0.9
        )
    }
}