//
//  HeroSearchViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/08.
//

import UIKit

class HeroSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var heroSearchBar: UISearchBar!
    private let searchViewModel = HeroSearchViewModel()
    @IBOutlet private weak var searchResultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroSearchBar?.delegate = self
        searchResultsTable?.delegate = self
        searchResultsTable?.dataSource = self
    }
    
}

// MARK: - UITableView DataSource functions

extension HeroSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.searchCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchViewModel.searchTitle(at: indexPath.row)
        cell.detailTextLabel?.text = searchViewModel.searchSubTitle(at: indexPath.row)
        return cell
    }
}

// MARK: - UITableView Delegate functions

extension HeroSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchViewModel.selectedCity(at: indexPath.row)
    }
}
}
