//
//  github_issuesTests.swift
//  github-issuesTests
//
//  Created by César Ferreira on 16/12/20.
//  Copyright © 2020 cesar. All rights reserved.
//

import XCTest
import Moya
@testable import github_issues

class github_issuesTests: XCTestCase {

//    var networkManager: NetworkManager!
    var provider: MoyaProvider<API>!

    override func setUp() {
        super.setUp()

        // A mock provider with a mocking `endpointClosure` that stub immediately
        provider = MoyaProvider<API>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }

    func customEndpointClosure(_ target: API) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension API {
    var testSampleData: Data {
        switch self {
        case .issues(page: _):
            // Returning all-popular-movies.json
            let url = Bundle(for: github_issuesTests.self).url(forResource: "all-issues", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
}
