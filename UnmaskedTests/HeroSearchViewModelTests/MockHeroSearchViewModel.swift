//
//  MockedHeroSearchViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/12.
//

import Foundation
@testable import Unmasked

class MockHeroSearchViewModel {
    private var repository: SuperheroRepositorySearchable
    private var response: SuperheroSearchResponseModel?
    
    init(repository: SuperheroRepositorySearchable) {
        self.repository = repository
    }
    
    func fetchHeroes(with name: String) {
        repository.fetchHeroes(with: name, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
            case .failure(_):
                return
            }
        })
    }
    
    var myHeroList: [SuperheroResponseModel]? {
        response?.results
    }
    
    var heroListCount: Int {
        myHeroList?.count ?? 0
    }
    
    func hero(at index: Int) -> SuperheroResponseModel? {
        myHeroList?[index]
    }
}
