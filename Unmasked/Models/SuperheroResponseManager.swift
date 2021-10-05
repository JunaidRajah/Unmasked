//
//  SuperheroResponseManager.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/05.
//

import Foundation

protocol SuperheroResponseManagerDelegate {
    func didProcessHero(_ responseManager: SuperheroResponseManager, hero: SuperheroData)
    func didFailWithError(error: Error)
}

struct SuperheroResponseManager {
    private let superheroURL = "https://superheroapi.com/api/4431906776894007"
    var delegate: SuperheroResponseManagerDelegate?

    mutating func fetchSuperhero(with id: String) {
        let urlString = "\(superheroURL)/\(id)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session =  URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let superhero = self.parseJSON(safeData) {
                        self.delegate?.didProcessHero(self, hero: superhero)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ superheroData: Data) -> SuperheroData? {
        do {
            let decodedData = try JSONDecoder().decode(SuperheroData.self, from: superheroData)
            return decodedData
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
