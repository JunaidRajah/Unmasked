//
//  SuperheroResponseManager.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/05.
//

import Foundation

struct SuperheroRepository: SuperheroRepositoryFetchable {

    private let superheroURL = "https://superheroapi.com/api/4431906776894007"

    func fetchHero(with id: String, completion: @escaping superheroResult) {
        let urlString = "\(superheroURL)/\(id)"
        if let url = URL(string: urlString) {
            let session =  URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure(error as! URLError))
                }
                if let safeData = data {
                    if let superhero = self.parseJSON(safeData) {
                        print(superhero.name)
                        completion(.success(superhero))
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ superheroData: Data) -> SuperheroResponseModel? {
        do {
            let decodedData = try JSONDecoder().decode(SuperheroResponseModel.self, from: superheroData)
            return decodedData
            
        } catch {
            print(error)
            return nil
        }
    }
}
