//
//  AddNoteCell.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 17.11.2022.
//

import UIKit

final class AddNoteCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "AddNoteCell"

    private var textView = UITextView()
    public var addButton = UIButton()

    var delegate = NotesViewController()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func disableButton() {
        addButton.isEnabled = false
        addButton.alpha = 0.5
    }

    private func enableButton() {
        addButton.isEnabled = true
        addButton.alpha = 1
    }

    fileprivate func setupButton() {
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self,
                action: #selector(addButtonTapped(_:)),
                for: .touchUpInside
        )

        disableButton()
    }

    private func showTextLabel() {
        textView.textColor = .tertiaryLabel
        textView.text = "Start typing..."
    }

    fileprivate func setupTextView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.backgroundColor = .clear
        textView.setHeight(140)
        textView.delegate = self

        showTextLabel()
    }

    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)

        stackView.pin(to: contentView, [.top, .right, .left, .bottom], 16)
        contentView.backgroundColor = .secondarySystemBackground
    }

    private func setupView() {
        setupTextView()
        setupButton()
        setupStackView()
    }

    @objc
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            disableButton()
        } else {
            enableButton()
        }
    }

    @objc
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .tertiaryLabel {
            textView.text = ""
            textView.textColor = .label
        }
    }

    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if textView.text != "" {
            delegate.newNoteAdded(note: ShortNote(text: textView.text))

            disableButton()
            showTextLabel()
        }
    }
}
