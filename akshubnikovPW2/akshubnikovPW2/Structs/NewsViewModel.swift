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
    var imageData: Data?

    init(title: String, description: String?, urlToImage: URL? = nil, imageData: Data? = nil) {
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.imageData = imageData
    }
}
