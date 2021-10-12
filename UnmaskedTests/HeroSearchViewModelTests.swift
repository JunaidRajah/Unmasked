//
//  HeroSearchViewModelTests.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/12.
//

import XCTest
@testable import Unmasked

class HeroSearchViewModelTests: XCTestCase, ViewModelDelegate {
    
    private var mockHeroSearchRepository: MockSuperheroSearchRepository!
    private var mockHeroSearchApiClient: MockHeroSearchApiClient!

    override func setUp() {
        mockHeroSearchApiClient = MockHeroSearchApiClient()
        mockHeroSearchRepository = MockSuperheroSearchRepository(heroApiProtocol: mockHeroSearchApiClient)
    }
    
    func testSuccessfulViewModelInitialization() throws {
        XCTAssert(initializeHeroSearchViewModel(with: "Heat Wave").myHeroList != nil)
    }
    
    func testHeroCountAfterSuccessfulCall() throws {
        XCTAssert(initializeHeroSearchViewModel(with: "Heat Wave").heroListCount == 1)
    }
    
    func testHeroAtIndex() throws {
        XCTAssert(initializeHeroSearchViewModel(with: "Heat Wave").hero(at: 0)!.name == "Heat Wave")
    }
    
    private func initializeHeroSearchViewModel(with name: String) -> HeroSearchViewModel {
        let heroViewModel = HeroSearchViewModel(repository: mockHeroSearchRepository, delegate: self)
        mockHeroSearchApiClient.apiResult = .success(mockedSearch)
        heroViewModel.fetchHeroes(with: name)
        return heroViewModel
    }
    
    func refreshViewContents() {
        return
    }
    
    func showErrorMessage(error: Error) {
        return
    }
    
}

