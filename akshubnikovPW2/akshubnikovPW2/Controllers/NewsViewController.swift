//
//  NewsViewController.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 06.12.2022.
//

import UIKit

final class NewsViewController: UIViewController {
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    public func configure(with viewModel: NewsViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.description
        }

        setupImage(viewModel)
    }

    // MARK: - Private methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavbar()

        setImageView()
        setTitleLabel()
        setDescriptionLabel()
    }

    private func setupNavbar() {
        navigationItem.title = "News"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.left"),
                style: .plain,
                target: self,
                action: #selector(goBack)
        )

        navigationItem.leftBarButtonItem?.tintColor = .label
    }

    private func setImageView() {
        imageView.image = UIImage(named: "landscape")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)

        imageView.pin(to: view, [.left, .right], 0)
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinHeight(to: imageView.widthAnchor, 1)
    }

    private func setTitleLabel() {
        titleLabel.text = "Hello"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        view.addSubview(titleLabel)

        titleLabel.pinTop(to: imageView.bottomAnchor, 12)
        titleLabel.pin(to: view, [.left, .right], 16)
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }

    private func setDescriptionLabel() {
        descriptionLabel.text = "World"
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        view.addSubview(descriptionLabel)

        descriptionLabel.pin(to: view, [.left, .right], 16)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 8)
    }

    private func setupImage(_ news: NewsViewModel) {
        if let data = news.imageData {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        } else if let url = news.urlToImage {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                        guard let data = data else {
                            return
                        }

                        DispatchQueue.main.async {
                            news.imageData = data
                            self?.imageView.image = UIImage(data: news.imageData ?? Data())
                        }
                    }
                    .resume()
        }
    }

    // MARK: - Objc functions

    @objc
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
