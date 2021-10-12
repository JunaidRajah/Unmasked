//
//  HeroSearchViewModelTests.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/12.
//

import XCTest
@testable import Unmasked

class HeroSearchViewModel: XCTestCase {

    private var mockHeroSearchRepository: MockSuperheroSearchRepository!
    private var mockHeroSearchViewModel: MockHeroSearchViewModel!
    private var mockHeroSearchApiClient: MockHeroSearchApiClient!

    override func setUp() {
        mockHeroSearchApiClient = MockHeroSearchApiClient()
        mockHeroSearchRepository = MockSuperheroSearchRepository()
        mockHeroSearchViewModel = MockHeroSearchViewModel(repository: mockHeroSearchRepository)
    }
    
    func testSuccessfulApiCallProducesResponse() throws {
        mockHeroSearchViewModel.fetchHeroes(with: "Heat Wave")
        XCTAssert(!mockHeroSearchViewModel.myHeroList!.isEmpty)
    }
    
    func testFailedApiCallDoesNotProduceViewModelResponse() throws {
        mockHeroSearchApiClient.apiResult = .failure(URLError(.badServerResponse))
        XCTAssert(mockHeroSearchViewModel.myHeroList == nil)
    }
    
    func testHeroAtIndex() throws {
        mockHeroSearchViewModel.fetchHeroes(with: "Heat Wave")
        XCTAssert(mockHeroSearchViewModel.hero(at: 0)!.name == "Heat Wave")
    }
    
}

