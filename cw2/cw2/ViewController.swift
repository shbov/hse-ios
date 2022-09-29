//
//  ViewController.swift
//  cw2
//
//  Created by Andrew Shubnikov on 27.09.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.pinLeft(to: view.rightAnchor, 40)
        button.pinRight(to: view.leftAnchor, 40)
    }
}
