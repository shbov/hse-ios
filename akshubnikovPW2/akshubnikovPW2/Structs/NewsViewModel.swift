//
//  NewsViewModel.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 06.12.2022.
//

import UIKit

struct AllNews: Decodable {
    let articles: [NewsViewModel]
}

public class NewsViewModel: Decodable {
    let title: String
    let description: String?
    var urlToImage: URL?

    init(title: String, description: String?, urlToImage: URL? = nil, imageData: Data? = nil) {
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
    }
}

extension NewsViewModel: Hashable {
    public static func ==(lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        return lhs.title == rhs.title
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
