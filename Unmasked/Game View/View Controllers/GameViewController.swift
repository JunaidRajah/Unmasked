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
    
    private func loadImage(with imageURL: String, imageView: UIImageView) {
        if let url = URL(string: imageURL) {
            imageView.image = UIImage(systemName: "arrow.clockwise")
            DispatchQueue.main.async {
                imageView.load(url: url)
            }
        }
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
        loadImage(with: gameViewModel.heroOneImageURL, imageView: heroOneImage)
        
        heroTwoName.text = gameViewModel.heroTwoName
        loadImage(with: gameViewModel.heroTwoImageURL, imageView: heroTwoImage)
        
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
