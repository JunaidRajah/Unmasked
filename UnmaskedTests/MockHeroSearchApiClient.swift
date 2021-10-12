//
//  MockApiClient.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/12.
//

import Foundation
@testable import Unmasked

class MockHeroSearchApiClient: SuperheroRepositorySearchable {

    var apiResult: Result<SuperheroSearchResponseModel, Error> = .failure(URLError(.badServerResponse))

    func fetchHeroes(with name: String, completion: @escaping superheroSearchResult) {
        completion(apiResult)
    }
}
