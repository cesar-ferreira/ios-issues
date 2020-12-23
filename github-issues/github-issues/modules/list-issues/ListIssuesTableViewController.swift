//
//  ListIssuesTableViewController.swift
//  github-issues
//
//  Created by César Ferreira on 19/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import UIKit

class ListIssuesTableViewController: UITableViewController, StoryboardInstantiable {

    private let viewModel = ListIssuesViewModel()
    private var issue: IssueResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        viewModel.delegate = self
        viewModel.loadIssues(page: "1")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.issues?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_issue", for: indexPath)
                
        let issue = viewModel.issues?[indexPath.row]
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        cell.textLabel?.text = issue?.title
        cell.detailTextLabel?.text = issue?.state
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.issue = viewModel.issues?[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: false)
        let viewController = DetailsViewController.instantiateViewController()
        viewController.issue = self.issue
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ListIssuesTableViewController: ListIssuesViewModelProtocol {
    func didUpdatIssues() {
        self.tableView.reloadData()
        print(viewModel.issues ?? [])
    }
}
