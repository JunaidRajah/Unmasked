//
//  MockSuperheroSearchRepository.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/12.
//

import Foundation
@testable import Unmasked

class MockSuperheroSearchRepository: SuperheroRepositorySearchable {
    
    private var heroApiProtocol: SuperheroRepositorySearchable
    
    var heroResponse: SuperheroSearchResponseModel?
    
    init(heroApiProtocol: SuperheroRepositorySearchable) {
        self.heroApiProtocol = heroApiProtocol
    }
    
    func fetchHeroes(with name: String, completion: @escaping superheroSearchResult) {
        heroApiProtocol.fetchHeroes(with: name, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.heroResponse = response
                completion(.success(mockedSearch))
            case .failure(_):
                completion(.failure(URLError(.badServerResponse)))
            }
        })
    }
}
