//
//  SuperheroResponseManager.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/05.
//

import Foundation

struct SuperheroRepository: SuperheroRepositoryFetchable {

    func fetchHero(with id: String, completion: @escaping superheroResult) {
        if let url = URLHeroStringBuilder(for: id) {
            let session =  URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if let safeData = data {
                    do {
                        let superhero = try JSONDecoder().decode(SuperheroResponseModel.self, from: safeData)
                        completion(.success(superhero))
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    private func URLHeroStringBuilder(for id: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.URLBuilder.scheme
        urlComponents.host = Constants.URLBuilder.host
        urlComponents.path = Constants.URLBuilder.path
        let apiKeyQueryItem = URLQueryItem(name: Constants.URLBuilder.apiKeyString,
                                           value: Constants.URLBuilder.apiKey)
        let heroSearchQueryItem = URLQueryItem(name: Constants.URLBuilder.path, value: id)
        urlComponents.queryItems = [apiKeyQueryItem, heroSearchQueryItem]
        let heroURL = urlComponents.url?.absoluteString
            .replacingOccurrences(of: "?", with: "")
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "&", with: "")
        return URL(string: heroURL!)
    }
}
