//
//  HeroCollectionViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import UIKit
import UnmaskedEngine

class HeroCollectionViewController: UIViewController {
    
    private lazy var heroCollectionViewModel = HeroCollectionViewModel(repository: SuperheroRepository(),
                                                                       collectionRepository: SuperheroCollectionRepository(),
                                                                       delegate: self)
    @IBOutlet private weak var heroTable: UITableView!
    @IBOutlet private weak var groupNameLabel: UILabel!
    @objc var heroGroup: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroTable.register(HeroTableViewCell.nib(), forCellReuseIdentifier: HeroTableViewCell.identifier)
        heroTable?.delegate = self
        heroTable?.dataSource = self
        heroCollectionViewModel.fetchCollection(heroGroup: heroPublisher.allCases[heroGroup-1])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionToUnmasked" {
            super.prepare(for: segue, sender: sender)
            let destination = segue.destination as! UnmaskedViewController
            guard let selectedHero = heroCollectionViewModel.selectedHero else { return }
            destination.hero = selectedHero
            destination.heroGroup = heroGroup
        }
    }
}

// MARK: - UITableView DataSource functions

extension HeroCollectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroCollectionViewModel.heroListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let heroCell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier,
                                                           for: indexPath) as? HeroTableViewCell else {
            return HeroTableViewCell()
        }
        
        if let hero = heroCollectionViewModel.hero(at: indexPath.row){
            heroCell.configure(with: hero)
        }
        return heroCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

// MARK: - UITableView Delegate functions

extension HeroCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        heroCollectionViewModel.selectHero(at: indexPath.row)
    }
}

// MARK: - ViewModel Delegate functions

extension HeroCollectionViewController: CollectionViewModelDelegate {
    func loadHeroFromCollection() {
        performSegue(withIdentifier: "collectionToUnmasked", sender: self)
    }
    
    func refreshViewContents() {
        groupNameLabel.text = "\(heroPublisher.allCases[heroGroup-1].rawValue) Universe"
        self.heroTable.reloadData()
    }

    func showErrorMessage(error: Error) {
        Alert.showCollectionHeroSelectFailAlert(on: self)
    }
}
