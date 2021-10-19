//
//  UnmaskedTests.swift
//  UnmaskedTests
//
//  Created by Junaid Rajah on 2021/10/01.
//

import XCTest
@testable import Unmasked

class HeroSearchViewModelTests: XCTestCase {

    private var viewModel: HeroSearchViewModel!
    private var mockDelegate: MockDelegate!
    private var mockRepository: MockRepository!
    
    override func setUp() {
        mockDelegate = MockDelegate()
        mockRepository = MockRepository()
        viewModel = HeroSearchViewModel(repository: mockRepository, delegate: mockDelegate)
    }
    
    func testFetchSearchHeroSuccess() {
        setResponseSuccess()
        XCTAssertEqual(viewModel.myHeroList?.first?.name, "Heat Wave")
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testFetchSearchHeroFailure() {
        viewModel.fetchHeroes(with: "")
        XCTAssert(mockDelegate.showErrorCalled)
    }
    
    func testCountReturnsCorrectValue() {
        setResponseSuccess()
        XCTAssertEqual(viewModel.heroListCount, 1)
    }
    
    func testCountReturnsCorrectValueNil() {
        viewModel.fetchHeroes(with: "")
        XCTAssertEqual(viewModel.heroListCount, 0)
    }
    
    func testHeroAtCorrectValue() {
        setResponseSuccess()
        XCTAssertEqual(viewModel.hero(at: 0)?.name, "Heat Wave")
    }
    
    func testHeroAtCorrectValueNil() {
        viewModel.fetchHeroes(with: "")
        XCTAssertEqual(viewModel.hero(at: 0)?.name, nil)
    }
    
    private func setResponseSuccess() {
        mockRepository.response = .success(mockData)
        viewModel.fetchHeroes(with: "")
    }
    
    private var mockData: SuperheroSearchResponseModel {
        return SuperheroSearchResponseModel(response: "success",
                                            resultsFor: "Heat Wave",
                                            results: [
                                            SuperheroResponseModel(response: nil,
                                                                   id: "320",
                                                                   name: "Heat Wave",
                                                                   powerstats: Powerstats(intelligence: "38",
                                                                                          strength: "10",
                                                                                          speed: "17",
                                                                                          durability: "45",
                                                                                          power: "27",
                                                                                          combat: "30"),
                                                                   biography: Biography(fullName: "Mick Rory",
                                                                                        alterEgos: "No alter egos found.",
                                                                                        aliases: ["Rory Calhoun"],
                                                                                        placeOfBirth: "-",
                                                                                        firstAppearance: "Flash #140 (November, 1963)",
                                                                                        publisher: "DC Comics",
                                                                                        alignment: "bad"),
                                                                   appearance: Appearance(gender: "Male",
                                                                                          race: "Human",
                                                                                          height: ["5'11", "180 cm"],
                                                                                          weight: ["179 lb", "81 kg"],
                                                                                          eyeColor: "Blue",
                                                                                          hairColor: "No Hair"),
                                                                   work: Work(occupation: "Professional Criminal",
                                                                              base: "Central City"),
                                                                   connections: Connections(groupAffiliation: "Rogues; formerly Secret Society of Super-Villains, Legion of Doom",
                                                                                            relatives: "-"),
                                                                   image: Image(url: "https://www.superherodb.com/pictures2/portraits/10/100/705.jpg"))
                                            ])
    }
    
    class MockDelegate: ViewModelDelegate {
        var refreshCalled = false
        var showErrorCalled = false
        
        func refreshViewContents() {
            refreshCalled = true
        }
        
        func showErrorMessage(error: Error) {
            showErrorCalled = true
        }
    }
    
    class MockRepository: SuperheroRepositorySearchable {
        var response: Result<SuperheroSearchResponseModel, Error> = .failure(URLError(.badServerResponse))
        
        func fetchHeroes(with name: String, completion: @escaping superheroSearchResult) {
            completion(response)
        }
    }

}
