//
//  HeroCollectionViewModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import Foundation
import Firebase

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
    
    func fetchCollection(heroGroup: Int) {
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
                    var groupItems: [superheroCollectionModel] = []
                    switch heroGroup {
                    case 1:
                        groupItems = self.filterCollection(with: "Marvel Comics", collection: newItems)
                    case 2:
                        groupItems = self.filterCollection(with: "DC Comics", collection: newItems)
                    case 3:
                        groupItems = self.filterCollection(with: "George Lucas", collection: newItems)
                    case 4:
                        groupItems = self.filterCollection(with: "Shueisha", collection: newItems)
                    case 5:
                        groupItems = self.filterCollection(with: "Dark Horse Comics", collection: newItems)
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
                self.refObservers.append(completed)
            }
        }
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
