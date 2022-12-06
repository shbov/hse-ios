//
//  NewsListViewController.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 06.12.2022.
//

import UIKit

final class NewsListViewController: UIViewController {
    public var tableView = UITableView(frame: .zero, style: .plain)
    public var isLoading = false
    public var newsViewModels = [NewsViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchNews()
    }

    // MARK: - Private methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavbar()
        configureTableView()
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

    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setTableViewUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        tableView.rowHeight = 120
        tableView.pinLeft(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: view)
        tableView.pinBottom(to: view)
    }

    private func setTableViewCell() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }

    private func fetchNews() {
        ApiService.shared.GET(endpoint: ApiService.Endpoint.news) {
            [weak self] (result: Result<AllNews, ApiService.APIError>) in
            switch result {
            case .success(let news):
                self?.newsViewModels = news.articles.compactMap {
                    let url = $0.urlToImage ??
                            URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg")
                    return NewsViewModel(
                            title: $0.title,
                            description: ($0.description ?? "No description"),
                            urlToImage: url
                    )
                }

                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Objc functions

    @objc
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
