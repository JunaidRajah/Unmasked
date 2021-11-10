//
//  HeroCollectionViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import Foundation
import Firebase

enum heroPublisher: String, CaseIterable {
    case Marvel = "Marvel Comics"
    case DC = "DC Comics"
    case StarWars = "George Lucas"
    case Anime = "Shueisha"
    case DarkHorse = "Dark Horse Comics"
    case Other
}

class HeroCollectionViewModel {
    
    var ref = Database.database().reference()
    var handle: AuthStateDidChangeListenerHandle?
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
    
    func fetchCollection(heroGroup: heroPublisher) {
        handle = Auth.auth().addStateDidChangeListener { _, currentUser in
            if currentUser == nil {
                return
            } else {
                let completed = self.ref.child(currentUser!.uid).child("heroes").observe(.value) { snapshot in
                    var newItems: [superheroCollectionModel] = []
                    for child in snapshot.children {
                        if
                            let snapshot = child as? DataSnapshot,
                            let hero = superheroCollectionModel(snapshot: snapshot) {
                            newItems.append(hero)
                            print(hero.name)
                        }
                    }
                    self.collectionFromGroup(from: newItems, heroGroup: heroGroup)
                }
                self.refObservers.append(completed)
            }
        }
    }
    
    private func collectionFromGroup(from heroCollection: [superheroCollectionModel], heroGroup: heroPublisher) {
        var groupItems: [superheroCollectionModel] = []
        switch heroGroup {
        case .Marvel:
            groupItems = self.filterCollection(with: heroGroup.rawValue, collection: heroCollection)
        case .DC:
            groupItems = self.filterCollection(with: heroGroup.rawValue, collection: heroCollection)
        case .StarWars:
            groupItems = self.filterCollection(with: heroGroup.rawValue, collection: heroCollection)
        case .Anime:
            groupItems = self.filterCollection(with: heroGroup.rawValue, collection: heroCollection)
        case .DarkHorse:
            groupItems = self.filterCollection(with: heroGroup.rawValue, collection: heroCollection)
        case .Other:
            for hero in heroCollection {
                if hero.publisher != heroPublisher.Marvel.rawValue &&
                    hero.publisher != heroPublisher.DC.rawValue &&
                    hero.publisher != heroPublisher.StarWars.rawValue &&
                    hero.publisher != heroPublisher.Anime.rawValue &&
                    hero.publisher != heroPublisher.DarkHorse.rawValue {
                    groupItems.append(hero)
                }
            }
        }
        self.response = groupItems
        self.delegate?.refreshViewContents()
    }
    
    private func filterCollection(with publisher: String, collection: [superheroCollectionModel]) -> [superheroCollectionModel] {
        var filteredCollection: [superheroCollectionModel] = []
        for hero in collection {
            if hero.publisher == publisher {
                filteredCollection.append(hero)
            }
        }
        return filteredCollection
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
