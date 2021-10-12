//
//  mockHeroSearchData.swift
//  UnmaskedTests
//
//  Created by Junaid Rajah on 2021/10/12.
//

import Foundation
@testable import Unmasked

let mockedSearch = SuperheroSearchResponseModel(response: "success",
                                                resultsFor: "Heat Wave",
                                                results: [
                                                SuperheroResponseModel(response: nil,
                                                                       id: "320",
                                                                       name: "Heat Wave",
                                                                       powerstats: Powerstats(intelligence: "38",
                                                                                              strength: "10",
                                                                                              speed: "17",
                                                                                              durability: "45",
                                                                                              power: "27",
                                                                                              combat: "30"),
                                                                       biography: Biography(fullName: "Mick Rory",
                                                                                            alterEgos: "No alter egos found.",
                                                                                            aliases: ["Rory Calhoun"],
                                                                                            placeOfBirth: "-",
                                                                                            firstAppearance: "Flash #140 (November, 1963)",
                                                                                            publisher: "DC Comics",
                                                                                            alignment: "bad"),
                                                                       appearance: Appearance(gender: "Male",
                                                                                              race: "Human",
                                                                                              height: ["5'11", "180 cm"],
                                                                                              weight: ["179 lb", "81 kg"],
                                                                                              eyeColor: "Blue",
                                                                                              hairColor: "No Hair"),
                                                                       work: Work(occupation: "Professional Criminal",
                                                                                  base: "Central City"),
                                                                       connections: Connections(groupAffiliation: "Rogues; formerly Secret Society of Super-Villains, Legion of Doom",
                                                                                                relatives: "-"),
                                                                       image: Image(url: "https://www.superherodb.com/pictures2/portraits/10/100/705.jpg"))
                                                ])
