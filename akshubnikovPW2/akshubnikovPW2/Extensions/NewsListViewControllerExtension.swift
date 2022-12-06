//
//  NewsListViewControllerExtension.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 06.12.2022.
//

import UIKit

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {

        } else {
            let viewModel = newsViewModels[indexPath.row]
            if let newsCell = tableView.dequeueReusableCell(
                    withIdentifier: NewsCell.reuseIdentifier,
                    for: indexPath
            ) as? NewsCell {
                newsCell.configure(viewModel)
                return newsCell
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 0
        } else {
            return newsViewModels.count
        }
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading {
            let newsVC = NewsViewController()
            let viewModel = newsViewModels[indexPath.row]
            if tableView.dequeueReusableCell(
                    withIdentifier: NewsCell.reuseIdentifier,
                    for: indexPath
            ) is NewsCell {
                newsVC.configure(with: viewModel)
            }

            navigationController?.pushViewController(newsVC, animated: true)
        }
    }
}
