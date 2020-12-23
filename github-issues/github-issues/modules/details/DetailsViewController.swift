//
//  DetailsViewController.swift
//  github-issues
//
//  Created by César Ferreira on 21/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet private weak var imageProfile: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var linkButton: UIButton!
    var issue: IssueResponse? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupImage()
        setupLabel()
        setupDate()
    }
    
    private func setupImage() {
        imageProfile.downloaded(from: issue?.user.avatarURL ?? "")
        imageProfile?.layer.cornerRadius = (imageProfile?.frame.size.width ?? 0.0) / 2
        imageProfile?.clipsToBounds = true
        imageProfile?.layer.borderWidth = 3.0
        imageProfile?.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = issue?.title
        descriptionLabel.text = issue?.body
    }
    
    private func setupDate() {
       
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime
        ]
        
        let date = formatter.date(from: issue!.createdAt)
        print(date)
        dateLabel.text = date?.description

    }
    
    @IBAction func navigateToLinkURL(_ sender: Any) {
        guard let url = URL(string: issue?.htmlURL ?? "") else { return }
        UIApplication.shared.open(url)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }

    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                          .withTime,
                                          .withDashSeparatorInDate,
                                          .withColonSeparatorInTime]
        return formatter
    }()
}
