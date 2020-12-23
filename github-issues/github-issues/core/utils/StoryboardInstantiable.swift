//
//  StoryboardInstantiable.swift
//  github-issues
//
//  Created by César Ferreira on 22/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: fileName) as! Self
    }
}
