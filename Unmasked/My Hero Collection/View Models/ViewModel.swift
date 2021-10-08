//
//  ViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import Foundation

class ListViewModel {
    private var repository: SuperheroRepositoryFetchable
    private weak var delegate: ViewModelDelegate?
    private var response: SuperheroResponseModel?
    private var myHeroes = [SuperheroResponseModel]()
    
    init(repository: SuperheroRepositoryFetchable,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchHero(with id: String) {
        repository.fetchHero(with: id, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.delegate?.refreshViewContents()
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error)
            }
        })
    }
    
    func fetchHeroes() {
        for i in 1...6 {
            repository.fetchHero(with: String(i), completion: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.myHeroes.append(response)
                    if i == 6 {
                        self?.delegate?.refreshViewContents()
                    }
                case .failure(let error):
                   print(error)
                }
            })
        }
    }
    
    var heroName: String? {
        response?.name
    }
    
    var myHeroList: [SuperheroResponseModel] {
        myHeroes
    }

}
