//
//  HeroCollectionViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import UIKit

class HeroCollectionViewController: UIViewController {
    
    private lazy var heroCollectionViewModel = HeroCollectionViewModel(repository: SuperheroRepository(), delegate: self)
    @IBOutlet weak var heroTable: UITableView!
    var heroGroup: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroTable.register(HeroTableViewCell.nib(), forCellReuseIdentifier: HeroTableViewCell.identifier)
        heroTable?.delegate = self
        heroTable?.dataSource = self
        heroCollectionViewModel.fetchCollection(heroGroup: heroGroup)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedHeroFromCollection" {
            super.prepare(for: segue, sender: sender)
            let destination = segue.destination as! HeroViewController
            guard let selectedHero = heroCollectionViewModel.selectedHero else { return }
            destination.set(selectedHero)
            destination.setReturn(false)
        }
    }
}

// MARK: - UITableView DataSource functions

extension HeroCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
        performSegue(withIdentifier: "selectedHeroFromCollection", sender: self)
    }
    
    func refreshViewContents() {
        self.heroTable.reloadData()
    }

    func showErrorMessage(error: Error) {
        let alertController = UIAlertController(title: "Still Masked",
                                                message: "Heroes not yet added to the codex",
                                                preferredStyle: .alert)
        alertController.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
}