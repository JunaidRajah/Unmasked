//
//  SuperheroSearchRespository.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import Foundation

struct SuperheroSearchRepository: SuperheroRepositorySearchable {

    private let superheroURL = "https://superheroapi.com/api/\(apiKey)"

    func fetchHeroes(with name: String, completion: @escaping superheroSearchResult) {
        let urlString = "\(superheroURL)/search/\(name)"
        if let url = URL(string: urlString) {
            let session =  URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if let safeData = data {
                    if let superhero = self.parseJSON(safeData) {
                        completion(.success(superhero))
                    } else {
                        completion(.failure(error as! URLError))
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ superheroData: Data) -> SuperheroSearchResponseModel? {
        do {
            let decodedData = try JSONDecoder().decode(SuperheroSearchResponseModel.self, from: superheroData)
            return decodedData
            
        } catch {
            print(error)
            return nil
        }
    }
}
