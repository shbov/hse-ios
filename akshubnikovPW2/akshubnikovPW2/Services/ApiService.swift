//
//  ApiService.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 06.12.2022.
//

import Foundation

struct ApiService {
    let baseURL = URL(string: "https://newsapi.org/v2/")!
    let apiKey = "f09cf1ad7bf7404bbec4cdcaca4e0408"

    static let shared = ApiService()

    let decoder = JSONDecoder()

    enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }

    enum Endpoint {
        case news

        func path() -> String {
            switch self {
            case .news:
                return "top-headlines"
            }
        }
    }

    private func showRequestLog(_ method: String, _ url: String) {
        let reqString = method + " " + url

        let line = String(repeating: "=", count: reqString.count)
        print(line)
        print(reqString)
        print(line)
        print("")
        print("waiting for response...")
    }

    func GET<T: Decodable>(endpoint: Endpoint, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "country", value: "us")
        ]

        if let url = components?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            showRequestLog("GET", url.absoluteString)

            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.noResponse))
                    }
                    return
                }

                if let error = error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.networkError(error: error)))
                    }
                    return
                }

                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(object))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.jsonDecodingError(error: error)))
                    }
                }
            }

            task.resume()
        }
    }
}
