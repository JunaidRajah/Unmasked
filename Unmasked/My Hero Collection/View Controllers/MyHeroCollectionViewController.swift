//
//  MyHeroCollectionViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import UIKit

private let reuseIdentifier = "SuperheroToken"

class MyHeroCollectionViewController: UICollectionViewController, ViewModelDelegate {
    func refreshViewContents() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showErrorMessage(error: Error) {
        
    }
    

    private lazy var viewModel = ViewModel(repository: SuperheroRepository(), delegate: self)
    private var superheroManager = SuperheroRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "SuperheroTokenCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: reuseIdentifier)
        viewModel.fetchHeroes()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        viewModel.myHeroList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var superheroTokenCell = UICollectionViewCell()
    
        if let heroCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SuperheroTokenCollectionViewCell {
            let hero = viewModel.myHeroList[indexPath.row]
            print(hero.name)
            heroCell.setup(with: hero)
            superheroTokenCell = heroCell
        }
        return superheroTokenCell
    }
}
