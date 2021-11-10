//
//  GameViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/04.
//

import UIKit
import Firebase

class GameViewController: UIViewController {
    
    private lazy var gameViewModel =  GameViewModel(repository: SuperheroRepository(), delegate: self)

    @IBOutlet weak var heroOneImage: UIImageView!
    @IBOutlet weak var heroOneName: UILabel!
    @IBOutlet weak var heroTwoImage: UIImageView!
    @IBOutlet weak var heroTwoName: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewModel.startGame()
    }
    
    @IBAction func heroButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            gameViewModel.heroButtonPressed(isHeroOne: true)
        } else {
            gameViewModel.heroButtonPressed(isHeroOne: false)
        }
    }
}

extension GameViewController: ViewModelDelegate {
    func refreshViewContents() {
        heroOneImage.contentMode = .scaleAspectFit
        heroTwoImage.contentMode = .scaleAspectFit
        heroOneName.text = gameViewModel.heroOneName
        if let url = URL(string: gameViewModel.heroOneImageURL) {
            heroOneImage.image = UIImage(systemName: "arrow.clockwise")
            DispatchQueue.main.async {
                self.heroOneImage.load(url: url)
            }
        }
        
        heroTwoName.text = gameViewModel.heroTwoName
        if let url = URL(string: gameViewModel.heroTwoImageURL) {
            heroTwoImage.image = UIImage(systemName: "arrow.clockwise")
            DispatchQueue.main.async {
                self.heroTwoImage.load(url: url)
            }
        }
        
        statLabel.text = gameViewModel.statName
        scoreLabel.text = gameViewModel.currentScore
    }

    func showErrorMessage(error: Error) {
        let alertController = UIAlertController(title: "Critical Error",
                                                message: "Multiverse convergence engine has been compromised",
                                                preferredStyle: .alert)
        alertController.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
}
