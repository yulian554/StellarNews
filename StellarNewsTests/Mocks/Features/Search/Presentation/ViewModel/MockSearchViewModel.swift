//
//  MockSearchViewModel.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews

class MockSearchViewModel: SearchViewModel {
    var searchProductsCalled = false
    var lastSearchQuery: String?
    
    override func searchProducts(_ query: String) {
        searchProductsCalled = true
        lastSearchQuery = query
    }
}
