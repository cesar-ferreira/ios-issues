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

        print(issue)
        setupUI()
    }
    
    private func setupUI() {
        setupImage()
        setupLabel()
        setupDate()
    }
    
    private func setupImage() {
        imageProfile.downloaded(from: issue?.user.avatarURL ?? "")
    }
    
    private func setupLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = issue?.title
        descriptionLabel.text = issue?.body
    }
    
    private func setupDate() {
//        guard let isoDate = issue?.createdAt else { return }
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
//
//        guard let date = dateFormatter.date(from:isoDate) else { return }
//        let resultString = dateFormatter.string(from: date)

        
        
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
//        let date = inputFormatter.date(from: issue?.createdAt ?? "")
//        let resultString = inputFormatter.string(from: date!)
//        print(resultString)
        
        
        
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm:ss"
//
//        let date: NSDate = dateFormatterGet.date(from: issue?.createdAt ?? "")! as NSDate
        dateLabel.text = issue?.createdAt

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
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
