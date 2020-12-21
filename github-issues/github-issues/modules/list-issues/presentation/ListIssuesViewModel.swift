//
//  ListIssuesViewModel.swift
//  github-issues
//
//  Created by César Ferreira on 19/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

protocol ListIssuesViewModelProtocol: class {
    func didUpdatIssues()
}

class ListIssuesViewModel {
    weak var delegate: ListIssuesViewModelProtocol?
    
    fileprivate(set) var issues: [IssueResponse]?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadIssues(page: String) {
        networkManager.getIssues(page: page, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let issueResponse):
                strongSelf.issues = issueResponse
                strongSelf.delegate?.didUpdatIssues()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
