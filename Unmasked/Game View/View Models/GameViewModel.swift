//
//  GameViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/04.
//

import Foundation


class GameViewModel {
    
    private var repository: SuperheroRepositoryFetchable
    private weak var delegate: ViewModelDelegate?
    private var hero1: SuperheroResponseModel?
    private var hero2: SuperheroResponseModel?
    private var stat = 1
    private var score = 0
    
    init(repository: SuperheroRepositoryFetchable,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func startGame() {
        fetchHeroes()
        score = 0
    }
    
    func heroButtonPressed(isHeroOne: Bool) {
        var hero1Stat = 0
        var hero2Stat = 0
        switch stat {
        case 1:
            hero1Stat = Int(hero1?.powerstats.intelligence ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.intelligence ?? "0") ?? 0
        case 2:
            hero1Stat = Int(hero1?.powerstats.strength ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.strength ?? "0") ?? 0
        case 3:
            hero1Stat = Int(hero1?.powerstats.speed ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.speed ?? "0") ?? 0
        case 4:
            hero1Stat = Int(hero1?.powerstats.durability ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.durability ?? "0") ?? 0
        case 5:
            hero1Stat = Int(hero1?.powerstats.power ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.power ?? "0") ?? 0
        case 6:
            hero1Stat = Int(hero1?.powerstats.combat ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.combat ?? "0") ?? 0
        default:
            hero1Stat = Int(hero1?.powerstats.intelligence ?? "0") ?? 0
            hero2Stat = Int(hero2?.powerstats.intelligence ?? "0") ?? 0
        }
        stat = Int.random(in: 1...6)
        
        if isHeroOne == true {
            if hero1Stat >= hero2Stat {
                score += 1
                let heroTwoID = generateRandomID(heroIDToCheck: hero1?.id)
                fetchHero(isHeroOne: false, heroNo: heroTwoID)
            } else {
                score -= 1
                let heroOneID = generateRandomID(heroIDToCheck: hero2?.id)
                fetchHero(isHeroOne: true, heroNo: heroOneID)
            }
        } else {
            if hero2Stat >= hero1Stat {
                score += 1
                let heroOneID = generateRandomID(heroIDToCheck: hero2?.id)
                fetchHero(isHeroOne: true, heroNo: heroOneID)
            } else {
                score -= 1
                let heroTwoID = generateRandomID(heroIDToCheck: hero1?.id)
                fetchHero(isHeroOne: false, heroNo: heroTwoID)
            }
        }
    }
    
    private func generateRandomID(heroIDToCheck: String?) -> String {
        guard let heroOneID = heroIDToCheck else {
            return "1"
        }
        var heroTwoID = "\(Int.random(in: 1...732))"
        while heroOneID == heroTwoID {
            heroTwoID = "\(Int.random(in: 1...732))"
        }
        return heroTwoID
    }
    
    private func fetchHero(isHeroOne: Bool, heroNo: String) {
        repository.fetchHero(with: heroNo, completion: { [weak self] result in
            switch result {
            case .success(let response):
                if isHeroOne {
                    self?.hero1 = response
                } else {
                    self?.hero2 = response
                }
                self?.delegate?.refreshViewContents()
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error)
            }
        })
    }
    
    private func fetchHeroes() {
        let super1 = "\(Int.random(in: 1...732))"
        var super2 = "\(Int.random(in: 1...732))"
        while super2 == super1 {
            super2 = "\(Int.random(in: 1...732))"
        }
        stat = Int.random(in: 1...6)
        
        fetchHero(isHeroOne: true, heroNo: super1)
        fetchHero(isHeroOne: false, heroNo: super2)
    }
    
    var heroOneImageURL: String {
        hero1?.image.url ?? ""
    }
    
    var heroTwoImageURL: String {
        hero2?.image.url ?? ""
    }
    
    var heroOneName: String {
        hero1?.name ?? "Masked"
    }
    
    var heroTwoName: String {
        hero2?.name ?? "Masked"
    }
    
    var statName: String {
        switch stat {
        case 1:
            return "intelligence"
        case 2:
            return "strength"
        case 3:
            return "speed"
        case 4:
            return "durability"
        case 5:
            return "power"
        case 6:
            return "combat"
        default:
            return "Hacked"
        }
    }
    
    var currentScore: String {
        "\(score)"
    }
    
}
