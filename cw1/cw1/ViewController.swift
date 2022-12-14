//
//  ViewController.swift
//  cw1
//
//  Created by Andrew Shubnikov on 13.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var OurView: UIView!
    
    @IBOutlet weak var Rectangle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    @IBAction func ButtonClick(_ sender: Any) {
        func getRandomValue() -> CGFloat {
            CGFloat.random(in: 0 ..< 2 * 128 ) / 255;
        }
        
        Rectangle.layer.cornerRadius = CGFloat.random(in: 0 ..<  (Rectangle.frame.height / 2));

        OurView.backgroundColor = UIColor(
            red: getRandomValue(),
            green: getRandomValue(),
            blue: getRandomValue(),
            alpha: 1
        )
    }
}

