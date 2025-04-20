//
//  TestUtils.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest

func awaitForTest(
    completion: (XCTestExpectation) async -> Void
) async {
    let expectation = XCTestExpectation(description: "Load articles")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        expectation.fulfill()
    }
    await completion(expectation)
}
