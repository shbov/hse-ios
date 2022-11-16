//
//  WelcomeViewController.swift
//  akshubnikovPW2
//
//  Created by Andrew Shubnikov on 29.09.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let incrementButton = UIButton(type: .system)
    private let valueLabel = UILabel()
    private var value: Int = 0

    private var buttonsSV = UIStackView()
    private var commentView = UIView()

    private let colorPaletteView = ColorPaletteView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupIncrementButton() {
        incrementButton.setTitle("Press me", for: .normal)
        incrementButton.setTitleColor(.label, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .systemBackground
        incrementButton.layer.applyShadow()

        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left, .right], 24)

        incrementButton.addTarget(self,
                action: #selector(incrementButtonPressed),
                for: .touchUpInside
        )
    }

    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .label
        valueLabel.text = "\(value)"

        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }

    private func setupView() {
        view.backgroundColor = .secondarySystemBackground

        colorPaletteView.isHidden = true
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
    }

    @discardableResult
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .systemBackground
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)

        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left, .right], 24)
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .label
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        commentView.addSubview(commentLabel)

        commentLabel.pin(to: commentView, [.top, .left, .bottom, .right], 16)
        return commentView
    }

    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "! ! ! ! ! ! ! ! ! "
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }

    func updateUI() {
        UIView.transition(with: commentLabel, duration: 0.25, options: .transitionFlipFromLeft, animations: {
            self.valueLabel.text = "\(self.value)"
        })
    }

    @objc
    private func incrementButtonPressed() {
        self.value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        UIView.animate(withDuration: 1, animations: {
            self.updateUI()
            self.updateCommentLabel(value: self.value)
        })
    }

    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .systemBackground
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }

    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")

        buttonsSV = UIStackView(arrangedSubviews: [
            colorsButton,
            notesButton,
            newsButton
        ])

        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually

        self.view.addSubview(buttonsSV)

        buttonsSV.pin(to: self.view, [.left, .right], 24)
        buttonsSV.pinBottom(to: self.view, 24)

        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(noteButtonPressed), for: .touchUpInside)
    }

    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)

        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(
                    equalTo: incrementButton.bottomAnchor,
                    constant: 8
            ),
            colorPaletteView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 24
            ),
            colorPaletteView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -24
            ),
            colorPaletteView.bottomAnchor.constraint(
                    equalTo: buttonsSV.topAnchor,
                    constant: -8
            )
        ])

        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
    }

    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden = !colorPaletteView.isHidden
        let generator = UIImpactFeedbackGenerator(style: .medium)

        generator.impactOccurred()
    }

    @objc
    private func noteButtonPressed() {
//        colorPaletteView.isHidden = true
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let notesController = NotesViewController()
        navigationController?.pushViewController(notesController, animated: true)
    }

    @objc
    private func changeColor() {
        UIView.animate(
                withDuration: 0.5,
                animations: {
                    self.view.backgroundColor = self.colorPaletteView.chosenColor
                }
        )
    }
}
