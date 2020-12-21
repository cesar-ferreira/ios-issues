//
//  NetworkManager.swift
//  github-issues
//
//  Created by César Ferreira on 19/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import Moya
import Mapper

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func getIssues(page: String, completion: @escaping (Result<[IssueResponse], Error>) -> ())
}

class NetworkManager: Networkable {
    
    
    let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func getIssues(page: String, completion: @escaping (Result<[IssueResponse], Error>) -> ()) {
        request(target: .issues(page: page), completion: completion)
    }
}

private extension NetworkManager {
    
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
