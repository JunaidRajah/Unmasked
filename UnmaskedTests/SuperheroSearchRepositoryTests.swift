//
//  SuperheroSearchRepositoryTests.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/12.
//

import XCTest
@testable import Unmasked

class SuperheroSearchRepositoryTests: XCTestCase {
    
    private var mockHeroSearchRepository: MockSuperheroSearchRepository!
    private var mockHeroSearchApiClient: MockHeroSearchApiClient!

    override func setUp() {
        mockHeroSearchApiClient = MockHeroSearchApiClient()
        mockHeroSearchRepository = MockSuperheroSearchRepository(heroApiProtocol: mockHeroSearchApiClient)
    }
    
    func testSuccessfultestFailedApiCallProducesResponse() throws {
        mockHeroSearchApiClient.apiResult = .success(mockedSearch)
        mockHeroSearchRepository.fetchHeroes(with: "Heat Wave"){ _ in }
        XCTAssert(!(mockHeroSearchRepository.heroResponse?.results!.isEmpty)!)
    }
    
    func testSuccessfultestFailedApiCallDoesNotProduceResponse() throws {
        mockHeroSearchApiClient.apiResult = .failure(URLError(.badServerResponse))
        mockHeroSearchRepository.fetchHeroes(with: "what"){ _ in }
        XCTAssert(mockHeroSearchRepository.heroResponse?.results == nil)
    }
}
