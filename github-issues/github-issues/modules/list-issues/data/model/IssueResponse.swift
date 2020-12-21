//
//  IssueResponse.swift
//  github-issues
//
//  Created by César Ferreira on 19/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import Foundation

struct IssueResponse: Codable {
    let url, htmlURL: String
    let id, number: Int
    let title: String
    let user: User
    let state: String
    let locked: Bool
    let createdAt, updatedAt: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
        case id, number, title, user, state, locked
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case body
    }
}

// MARK: - User
struct User: Codable {
    let login: String
    let avatarURL, htmlURL, reposURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case reposURL = "repos_url"
    }
}
