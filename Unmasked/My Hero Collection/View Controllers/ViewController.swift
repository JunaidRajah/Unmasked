//
//  ViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var viewModel = ViewModel(repository: SuperheroRepository(), delegate: self)
    @IBOutlet private weak var responseLabel: UILabel!
    private var superheroManager = SuperheroRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchHero(with: "69")
    }
}

extension ViewController: ViewModelDelegate {
    
    func refreshViewContents() {
        DispatchQueue.main.async {
            self.responseLabel.text = self.viewModel.heroName
        }
    }
    
    func showErrorMessage(error: Error) {
        DispatchQueue.main.async {
            self.responseLabel.text = error.localizedDescription
        }
    }
}
