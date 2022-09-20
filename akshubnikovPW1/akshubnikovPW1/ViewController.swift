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

    func generateHexColor() -> String {
        let letters: String = "0123456789ABCDEF";

        return String((0...6).map { _ in
            letters.randomElement()!
        })
    }

    @IBAction func changeColorButtonPressed(_ sender: Any) {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(UIColor(rgb: generateHexColor()));
        }

        let button = sender as? UIButton
        button?.isEnabled = false

        UIView.animate(
                withDuration: 0.9,
                animations: {
                    for view in self.views {
                        view.layer.cornerRadius = 16
                        view.backgroundColor = set.popFirst()
                    }
                },
                completion: {
                    (value: Bool) in
                    button?.isEnabled = true
                }
        )
    }
}
