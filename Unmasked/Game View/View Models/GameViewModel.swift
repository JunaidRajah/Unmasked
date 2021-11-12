//
//  GameViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/04.
//

import Foundation
import Firebase

enum statistic: String, CaseIterable {
    case intelligence = "intelligence"
    case strength = "strength"
    case speed = "speed"
    case durability = "durability"
    case power = "power"
    case combat = "combat"
}

class GameViewModel {
    
    private var collectionRepository = SuperheroCollectionRepository()
    private var repository: SuperheroRepositoryFetchable
    private weak var delegate: GameViewModelDelegate?
    private var hero1: SuperheroResponseModel?
    private var hero2: SuperheroResponseModel?
    private var stat = statistic.intelligence
    private var score = 0
    private var unlockScore = 0
    private var gameViewStrings = String.GameViewStrings()
    private var user: User?
    
    init(repository: SuperheroRepositoryFetchable,
         delegate: GameViewModelDelegate) {
        
        self.repository = repository
        self.delegate = delegate
    }
    
    func startGame() {
        fetchHeroes()
        score = 0
    }
    
    private func assignHeroStat(hero: SuperheroResponseModel?) -> Int {
        switch stat {
        case .intelligence:
            return Int(hero?.powerstats.intelligence ?? "0") ?? 0
        case .strength:
            return Int(hero?.powerstats.strength ?? "0") ?? 0
        case .speed:
            return Int(hero?.powerstats.speed ?? "0") ?? 0
        case .durability:
            return Int(hero?.powerstats.durability ?? "0") ?? 0
        case .power:
            return Int(hero?.powerstats.power ?? "0") ?? 0
        case .combat:
            return Int(hero?.powerstats.combat ?? "0") ?? 0
        }
    }
    
    private func compareStats(selectedHeroStat: Int, heroStatToCompare: Int, isHeroOne: Bool) {
        if selectedHeroStat >= heroStatToCompare {
            score += 1
            isHeroOne ? incrementUnlock(with: hero1) : incrementUnlock(with: hero2)
            let heroTwoID = generateRandomID(heroIDToCheck: hero1?.id)
            fetchHero(isHeroOne: !isHeroOne, heroNo: heroTwoID)
        } else {
            if score > 0 {
                score -= 1
            }
            let heroOneID = generateRandomID(heroIDToCheck: hero2?.id)
            fetchHero(isHeroOne: isHeroOne, heroNo: heroOneID)
        }
    }
    
    func heroButtonPressed(isHeroOne: Bool) {
        
        let hero1Stat = assignHeroStat(hero: hero1)
        let hero2Stat = assignHeroStat(hero: hero2)
        
        stat = statistic.allCases.randomElement()!
        
        if isHeroOne == true {
            compareStats(selectedHeroStat: hero1Stat, heroStatToCompare: hero2Stat, isHeroOne: isHeroOne)
        } else {
            compareStats(selectedHeroStat: hero2Stat, heroStatToCompare: hero1Stat, isHeroOne: isHeroOne)
        }
    }
    
    private func incrementUnlock(with hero: SuperheroResponseModel?) {
        unlockScore += 1
        if unlockScore == 4 {
            unlockScore = 0
            let heroToSave = ["id": hero!.id,
                              "name": hero!.name,
                              "publisher": hero!.biography.publisher,
                              "alignment": hero!.biography.alignment,
                              "image": hero!.image.url]
            collectionRepository.addHero(with: hero?.name ?? "Unmasked", heroToSave: heroToSave)
            delegate?.showUnlockHeroAlert(with: hero?.name ?? "Glitch",
                                          with: hero?.biography.publisher ?? "Divergent Universe")
            fetchHeroes()
        }
    }
    
    private func generateRandomID(heroIDToCheck: String?) -> String {
        guard let heroOneID = heroIDToCheck else {
            return "1"
        }
        var heroTwoID = gameViewStrings.randomHeroID()
        while heroOneID == heroTwoID {
            heroTwoID = gameViewStrings.randomHeroID()
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
        let super1 = gameViewStrings.randomHeroID()
        var super2 = gameViewStrings.randomHeroID()
        while super2 == super1 {
            super2 = gameViewStrings.randomHeroID()
        }
        stat = statistic.allCases.randomElement()!
        
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
    
    var currentScore: String {
        "\(score)"
    }
    
    var statName: String {
        stat.rawValue
    }
}
