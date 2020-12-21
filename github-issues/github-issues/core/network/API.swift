//
//  ApiClient.swift
//  github-issues
//
//  Created by César Ferreira on 19/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import Moya

enum API {
    case issues(page: String)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/repos/apple/swift/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .issues:
            return "issues"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .issues(let page):
            return .requestParameters(parameters: ["page" : page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
