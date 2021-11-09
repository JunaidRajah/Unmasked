//
//  HeroCollectionViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import Foundation
import Firebase

class HeroCollectionViewModel {
    
    var ref = Database.database().reference(withPath: "heroes")
    var refObservers: [DatabaseHandle] = []
    private weak var delegate: CollectionViewModelDelegate?
    private var repository: SuperheroRepositoryFetchable
    private var response: [superheroCollectionModel]?
    private var heroToSend: SuperheroResponseModel?
    
    init(repository: SuperheroRepositoryFetchable,
         delegate: CollectionViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchCollection(heroGroup: Int){
        let completed = ref.observe(.value) { snapshot in
            var newItems: [superheroCollectionModel] = []
            for child in snapshot.children {
                if
                    let snapshot = child as? DataSnapshot,
                    let hero = superheroCollectionModel(snapshot: snapshot) {
                    newItems.append(hero)
                    print(hero.name)
                }
            }
            var groupItems: [superheroCollectionModel] = []
            switch heroGroup {
            case 1:
                for hero in newItems {
                    if hero.publisher == "Marvel Comics" {
                        groupItems.append(hero)
                    }
                }
            case 2:
                for hero in newItems {
                    if hero.publisher == "DC Comics" {
                        groupItems.append(hero)
                    }
                }
            case 3:
                for hero in newItems {
                    if hero.publisher == "George Lucas" {
                        groupItems.append(hero)
                    }
                }
            case 4:
                for hero in newItems {
                    if hero.publisher == "Shueisha" {
                        groupItems.append(hero)
                    }
                }
            case 5:
                for hero in newItems {
                    if hero.publisher == "Dark Horse Comics" {
                        groupItems.append(hero)
                    }
                }
            default:
                for hero in newItems {
                    if hero.publisher != "Marvel Comics" &&
                        hero.publisher != "DC Comics" &&
                        hero.publisher != "George Lucas" &&
                        hero.publisher != "Shueisha" &&
                        hero.publisher != "Dark Horse Comics" {
                        groupItems.append(hero)
                    }
                }
            }
            
            self.response = groupItems
            self.delegate?.refreshViewContents()
        }
        refObservers.append(completed)
    }
    
    func selectHero(at index: Int) {
        guard let response = self.response else { return }
        repository.fetchHero(with: response[index].id, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.heroToSend = response
                self?.delegate?.loadHeroFromCollection()
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error)
            }
        })
    }
    
    var selectedHero: SuperheroResponseModel? {
        heroToSend
    }
    
    var myHeroList: [superheroCollectionModel]? {
        response
    }
    
    var heroListCount: Int {
        myHeroList?.count ?? 0
    }
    
    func hero(at index: Int) -> superheroCollectionModel? {
        guard let response = self.response else {return nil}
        return response[index]
    }
}
