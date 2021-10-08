//
//  SuperheroSearchResponseModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import Foundation

struct SuperheroSearchResponseModel: Codable {
    let response: String
    let resultsFor: String
    let results: [SuperheroResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case response, results
        case resultsFor = "results-for"
    }
}
