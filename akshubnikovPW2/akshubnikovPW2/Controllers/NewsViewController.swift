//
//  NewsViewController.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 06.12.2022.
//

import UIKit
import Combine

final class NewsViewController: UIViewController {
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    public func configure(with viewModel: NewsViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.description
            self.setupImage(viewModel)
        }
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

    private func loadImage(for news: NewsViewModel) -> AnyPublisher<UIImage?, Never> {
        return Just(news.urlToImage)
                .flatMap({ _ -> AnyPublisher<UIImage?, Never> in
                    let url = news.urlToImage!
                    return ImageLoader.shared.loadImage(from: url)
                })
                .eraseToAnyPublisher()
    }

    private func showImage(image: UIImage?) {
        imageView.image = image
    }

    private func setupImage(_ news: NewsViewModel) {
        cancellable = loadImage(for: news).sink { [unowned self] image in
            self.showImage(image: image)
        }
    }

    // MARK: - Objc functions

    @objc
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
