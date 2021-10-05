//
//  ViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var responseLabel: UILabel!
    private var superheroManager = SuperheroResponseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superheroManager.delegate = self
        superheroManager.fetchSuperhero(with: "732")
    }
}

extension ViewController: SuperheroResponseManagerDelegate {
    func didProcessHero(_ responseManager: SuperheroResponseManager, hero: SuperheroData) {
        DispatchQueue.main.async {
            self.responseLabel.text = hero.name
        }
    }
    
    func didFailWithError(error: Error) {
        self.responseLabel.text = error.localizedDescription
    }
}
