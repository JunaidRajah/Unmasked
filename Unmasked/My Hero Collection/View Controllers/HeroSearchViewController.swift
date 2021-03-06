//
//  HeroSearchViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/08.
//

import UIKit
import UnmaskedEngine

class HeroSearchViewController: UIViewController {

    private lazy var searchViewModel = HeroSearchViewModel(repository: SuperheroSearchRepository(), delegate: self)
    @IBOutlet private weak var searchResultsTable: UITableView!
    @IBOutlet private weak var searchBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTable.register(HeroTableViewCell.nib(), forCellReuseIdentifier: HeroTableViewCell.identifier)
        searchResultsTable?.delegate = self
        searchResultsTable?.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedHeroFromSearch" {
            super.prepare(for: segue, sender: sender)
            let destination = segue.destination as! HeroViewController
            guard let selectedHero = searchViewModel.selectedHero else { return }
            destination.set(selectedHero)
            destination.setReturn(true)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchViewModel.fetchHeroes(with: searchBar.text ?? "")
    }
}

// MARK: - UITableView DataSource functions

extension HeroSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.heroListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let heroCell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier,
                                                           for: indexPath) as? HeroTableViewCell else {
            return HeroTableViewCell()
        }
        
        if let hero = searchViewModel.hero(at: indexPath.row){
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

extension HeroSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchViewModel.selectHero(at: indexPath.row)
        performSegue(withIdentifier: "selectedHeroFromSearch", sender: self)
    }
}

// MARK: - ViewModel Delegate functions

extension HeroSearchViewController: ViewModelDelegate {
    func refreshViewContents() {
        self.searchResultsTable.reloadData()
    }

    func showErrorMessage(error: Error) {
        Alert.showSearchFailAlert(on: self)
    }
}
