//
//  ViewController.swift
//  akshubnikovPW1
//
//  Created by Andrew Shubnikov on 18.09.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var changeColorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        changeColorButtonPressed(changeColorButton!)
    }

    func colorFromHexString(_ hexCode: String!) -> UIColor {
        let scanner = Scanner(string: hexCode)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "$+#")
        var hex: CUnsignedLongLong = 0
        if (!scanner.scanHexInt64(&hex)) {
            return UIColor()
        }

        let r = (hex >> 16) & 0xFF;
        let g = (hex >> 8) & 0xFF;
        let b = (hex) & 0xFF;

        return UIColor.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: 1
        )
    }

    func generateHexColor() -> String {
        var string = "#"
        for value in 1...9 {
            let random = CInt.random(in: 0...15)
            switch (random) {
            case 1...8:
                string += String(value)
            case 10:
                string += "A"
            case 11:
                string += "B"
            case 12:
                string += "C"
            case 13:
                string += "D"
            case 14:
                string += "E"
            case 15:
                string += "F"
            default:
                string += ""
            }
        }

        return string
    }

    @IBAction func changeColorButtonPressed(_ sender: Any) {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(colorFromHexString(generateHexColor()));
        }

        let button = sender as? UIButton
        UIView.animate(withDuration: 2, animations: {
            button?.isEnabled = false

            for view in self.views {
                view.layer.cornerRadius = 16
                view.backgroundColor = set.popFirst()
            }
        })

        button?.isEnabled = true
    }
}
