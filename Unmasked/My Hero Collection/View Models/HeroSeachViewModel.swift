//
//  HeroSeachViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/08.
//

import Foundation

class HeroSearchViewModel {
    private var repository: SuperheroRepositorySearchable
    private weak var delegate: ViewModelDelegate?
    private var response: SuperheroSearchResponseModel?
    private var myHeroes = [SuperheroResponseModel]()
    
    init(repository: SuperheroRepositorySearchable,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchHeroes(with name: String) {
        repository.fetchHeroes(with: name, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.delegate?.refreshViewContents()
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error)
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
