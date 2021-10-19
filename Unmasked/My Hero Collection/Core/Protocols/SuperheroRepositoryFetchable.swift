//
//  SuperheroRepositoryFetchable.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/06.
//

import Foundation

typealias superheroResult = (Result<SuperheroResponseModel, Error>) -> Void
typealias superheroSearchResult = (Result<SuperheroSearchResponseModel, Error>) -> Void

protocol SuperheroRepositoryFetchable {
    func fetchHero(with id: String, completion: @escaping superheroResult)
}

protocol SuperheroRepositorySearchable {
    func fetchHeroes(with name: String, completion: @escaping superheroSearchResult)
}
